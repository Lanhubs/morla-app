import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/core/utils/snack_helper.dart';
import 'package:morla/features/history/data/models/invoice_model.dart';
import 'package:morla/features/invoices/data/models/invoice_item_model.dart';
import 'package:morla/features/new_invoice/data/models/new_invoice_model.dart';
import 'package:morla/features/new_invoice/data/repositories/new_invoice_repository.dart';
import 'package:morla/routes/app_routes.dart';

class HistoryController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  // Observable lists
  final RxList<Invoice> _invoices = <Invoice>[].obs;
  final RxList<Invoice> _filteredInvoices = <Invoice>[].obs;

  // Observable values
  final RxBool isLoading = false.obs;
  final Rxn<DateTime> fromDate = Rxn<DateTime>();
  final Rxn<DateTime> toDate = Rxn<DateTime>();
  final RxString selectedStatus = 'All Status'.obs;

  final List<String> statuses = [
    'All Status',
    'SENT',
    'PAID',
    'OVERDUE',
    'DRAFT',
  ];

  // Getters
  List<Invoice> get invoices => _invoices;
  List<Invoice> get filteredInvoices => _filteredInvoices;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(_onSearchChanged);
    fetchInvoices();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void _onSearchChanged() {
    filterInvoices();
  }

  // Fetch invoices from API
  Future<void> fetchInvoices() async {
    isLoading.value = true;

    try {
      final repo = Get.put(NewInvoiceRepository());
      final realInvoices = await repo.listInvoices();

      _invoices.value = realInvoices
          .map(
            (inv) => Invoice(
              id: inv.id ?? '',
              invoiceNumber: inv.invoiceNumber ?? inv.id ?? '',
              clientName: inv.clientName,
              clientId: inv.clientId,
              amount: inv.totalAmount,
              status: inv.status ?? 'DRAFT',
              date: inv.invoiceDate,
              dueDate: inv.dueDate,
              description: inv.items.isNotEmpty
                  ? inv.items.first.description
                  : 'Invoice Service',
            ),
          )
          .toList();

      filterInvoices();
    } catch (e) {
      SnackHelper.showError("Failed to fetch invoices $e");

    } finally {
      isLoading.value = false;
    }
  }

  // Filter invoices based on search and date range
  void filterInvoices() {
    final query = searchController.text.toLowerCase();
    final start = fromDate.value;
    final end = toDate.value;

    _filteredInvoices.value = _invoices.where((invoice) {
      final matchesSearch =
          query.isEmpty ||
          invoice.clientName.toLowerCase().contains(query) ||
          invoice.invoiceNumber.toLowerCase().contains(query) ||
          invoice.description.toLowerCase().contains(query);

      final invoiceDay = DateTime(
        invoice.date.year,
        invoice.date.month,
        invoice.date.day,
      );

      final startDay = start == null
          ? null
          : DateTime(start.year, start.month, start.day);
      final endDay = end == null
          ? null
          : DateTime(end.year, end.month, end.day);

      final isBeforeStart = startDay != null && invoiceDay.isBefore(startDay);
      final isAfterEnd = endDay != null && invoiceDay.isAfter(endDay);
      final matchesDateRange = !isBeforeStart && !isAfterEnd;
      final matchesStatus =
          selectedStatus.value == 'All Status' ||
          invoice.status == selectedStatus.value;

      return matchesSearch && matchesDateRange && matchesStatus;
    }).toList();

    _filteredInvoices.sort((a, b) => b.date.compareTo(a.date));
  }

  void updateDateRange(DateTime? start, DateTime? end) {
    fromDate.value = start;
    toDate.value = end;
    filterInvoices();
  }

  void selectStatus(String status) {
    selectedStatus.value = status;
    filterInvoices();
  }

  void clearDateRange() {
    fromDate.value = null;
    toDate.value = null;
    filterInvoices();
  }

  // Navigate to invoice details
  void viewInvoiceDetails(Invoice invoice) {
    final detailsInvoice = NewInvoiceModel(
      id: invoice.id,
      invoiceNumber: invoice.invoiceNumber,
      clientName: invoice.clientName,
      clientId: invoice.clientId,
      clientAddress: '',
      clientCity: '',
      clientEmail: '',
      clientPhone: '',
      invoiceDate: invoice.date,
      dueDate: invoice.dueDate ?? invoice.date.add(const Duration(days: 30)),
      currency: 'USD',
      taxRate: 0,
      paymentTerms: 'Net 30',
      memo: '',
      subtotal: invoice.amount,
      taxAmount: 0,
      totalAmount: invoice.amount,
      status: invoice.status,
      items: [
        InvoiceItem(
          description: invoice.description.isEmpty
              ? 'Invoice Service'
              : invoice.description,
          quantity: 1,
          price: invoice.amount,
          taxPercent: 0,
        ),
      ],
    );

    Get.toNamed(AppRoutes.invoiceDetails, arguments: detailsInvoice);
  }

  // Format currency
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
}
