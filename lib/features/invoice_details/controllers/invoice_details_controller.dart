import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:billkit/core/utils/snack_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:billkit/core/services/app_api_client.dart';
import 'package:billkit/features/new_invoice/data/models/new_invoice_model.dart';
import 'package:billkit/features/new_invoice/data/repositories/new_invoice_repository.dart';

class InvoiceDetailsController extends GetxController {
  final Rx<NewInvoiceModel?> invoice = Rx<NewInvoiceModel?>(null);
  final RxBool isLoading = true.obs;
  final RxBool isDownloading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final dynamic passed = Get.arguments;
    debugPrint(
      "InvoiceDetailsController onInit - Get.arguments type: ${passed.runtimeType}",
    );
    if (passed is NewInvoiceModel) {
      invoice.value = passed;
      _fetchFullDetails(passed.id!);
    } else {
      debugPrint("Get.arguments IS NOT NewInvoiceModel!");
      isLoading.value = false;
    }
  }

  Future<void> _fetchFullDetails(String id) async {
    isLoading.value = true;
    try {
      final repo = Get.put(NewInvoiceRepository());
      final fullInvoice = await repo.getInvoice(id);
      debugPrint("full invoice details: $fullInvoice");
      invoice.value = fullInvoice;
    } catch (e) {
      debugPrint('Error fetching invoice details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleEmailPings() {
    // Placeholder for future API support
  }

  Future<void> shareInvoice() async {
    final inv = invoice.value;
    if (inv == null || inv.id == null) return;
    SnackHelper.showInfo(
      "Please wait while we prepare your invoice",
      title: "Generating PDF",
    );

    try {
      final file = await _downloadPdfFile(
        inv.id!,
        inv.invoiceNumber ?? inv.id!,
        saveToDownloads: false,
      );

      await Share.shareXFiles([
        XFile(file.path),
      ], text: 'Here is your invoice ${inv.invoiceNumber ?? inv.id}');
    } catch (e) {
      SnackHelper.showError("Failed to generate invoice for sharing: $e");
    }
  }

  Future<void> downloadInvoice() async {
    final inv = invoice.value;
    if (inv == null || inv.id == null) return;
    isDownloading.value = true;
    try {
      final file = await _downloadPdfFile(
        inv.id!,
        inv.invoiceNumber ?? inv.id!,
        saveToDownloads: true,
      );
      SnackHelper.showSuccess(
        "Invoice saved to: ${file.path}",
        title: "Downloaded successfully",
      );
    } catch (e) {
      SnackHelper.showError('Failed to download invoice: $e');
    }
    isDownloading.value = false;
  }

  Future<File> _downloadPdfFile(
    String id,
    String invoiceNumber, {
    bool saveToDownloads = false,
  }) async {
    final apiClient = Get.find<AppApiClient>();

    final response = await apiClient.dio.get<List<int>>(
      '/invoices/$id/download',
      options: Options(responseType: ResponseType.bytes),
    );

    final bytes = response.data;
    if (bytes == null) {
      throw Exception('Received empty response from server');
    }

    Directory directory;
    if (saveToDownloads) {
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getApplicationDocumentsDirectory();
        }
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        final dlDir = await getDownloadsDirectory();
        directory = dlDir ?? await getApplicationDocumentsDirectory();
      }
    } else {
      directory = await getTemporaryDirectory();
    }

    final file = File('${directory.path}/invoice_$invoiceNumber.pdf');
    await file.writeAsBytes(bytes);

    return file;
  }

  void copyInvoiceLink() {
    final inv = invoice.value;
    if (inv == null) return;
    final link = 'https://BillKit.app/invoice/${inv.id}';
    Clipboard.setData(ClipboardData(text: link));
    SnackHelper.showInfo(
      "Invoice link copied to clipboard",
      title: "Link Copied",
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
