import 'package:billkit/features/dashboard/data/repositories/dashboard_repository.dart';
import 'package:billkit/features/history/data/models/invoice_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:billkit/core/utils/snack_helper.dart';
import 'package:billkit/core/services/app_api_client.dart';
import 'package:billkit/features/new_invoice/data/repositories/new_invoice_repository.dart';
import 'package:billkit/routes/app_routes.dart';

class DashboardController extends GetxController {
  DashboardRepository? _repository;

  DashboardController({DashboardRepository? repository}) : _repository = repository;

  @override
  void onInit() {
    super.onInit();
    // Ensure repository is available
    _repository ??= DashboardRepository(apiClient: Get.find<AppApiClient>());
    _loadDashboardStats();
  }
  final totalInvoices = 0.obs;
  final totalPaid = 0.0.obs;
  final totalUnpaid = 0.0.obs;
  final isLoading = false.obs;
  final RxList<Invoice> recentInvoices = <Invoice>[].obs;



  Future<void> _loadDashboardStats() async {
    if (_repository == null) {
      // Default values for when repository is not available
      totalInvoices.value = 0;
      totalPaid.value = 0.0;
      totalUnpaid.value = 0.0;
      isLoading.value = false;
      recentInvoices.value =[];
      return;
    }

    isLoading.value = true;
    try {
      final stats = await _repository!.getDashboardStats();
      debugPrint("stats: $stats");
      totalInvoices.value = stats.totalInvoices;
      totalPaid.value = stats.totalPaid;
      totalUnpaid.value = stats.totalUnpaid;
      recentInvoices.value = stats.invoices;
    } catch (e) {
      // Extract error message from backend response
      String errorMessage = 'Failed to load dashboard statistics';

      if (e is DioException) {
        final backendMessage = e.response?.data?['message'];
        if (backendMessage != null) {
          errorMessage = backendMessage.toString();
        }
      }
      SnackHelper.showError(errorMessage);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshDashboardStats() async {
    await _loadDashboardStats();
  }
   String formatCurrency(double amount) {
    final parts = amount.toStringAsFixed(2).split('.');
    final clean = parts[0];
    final regex = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    final formatted = clean.replaceAllMapped(regex, (Match m) => '${m[1]},');
    return '\$$formatted.${parts[1]}';
  }

  // Format date
  String formatDate(DateTime date) {
    final months = [
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

  // Navigate to invoice details fetched from backend
  Future<void> viewInvoiceDetails(Invoice invoice) async {
    final repo = Get.put(NewInvoiceRepository());
    try {
      final details = await repo.getInvoice(invoice.id);
      if (details != null) {
        Get.toNamed(AppRoutes.invoiceDetails, arguments: details);
      } else {
        SnackHelper.showError('Invoice not found');
      }
    } catch (e) {
      SnackHelper.showError('Failed to fetch invoice details: $e');
    }
  }

    final months = [
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
    
}
