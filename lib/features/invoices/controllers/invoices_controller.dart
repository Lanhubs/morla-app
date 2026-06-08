import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/services/app_api_client.dart';
import 'package:billkit/features/clients/data/models/client_model.dart';
import 'package:billkit/features/invoices/data/models/invoice_item_model.dart';
import 'package:billkit/features/new_invoice/data/models/new_invoice_model.dart';
import 'package:billkit/features/new_invoice/data/repositories/new_invoice_repository.dart';

class InvoicesController extends GetxController {
  // Tab state
  final activeTab = 'edit'.obs;

  // Invoice number
  final invoiceNumber = '#INV-0044'.obs;

  // Date
  final invoiceDate = DateTime.now().obs;

  // Due date
  final dueDate = DateTime.now().add(const Duration(days: 30)).obs;

  // Selected client
  final selectedClient = ''.obs;

  // Currency
  final selectedCurrency = 'USD'.obs;

  // Available currencies
  final List<String> currencies = ['USD', 'EUR', 'GBP', 'NGN', 'CAD', 'AUD'];

  // Itemization mode
  final isItemized = true.obs;

  // Invoice items
  final items = <InvoiceItem>[].obs;

  // Save as client template
  final saveAsTemplate = true.obs;

  // Loading state for API calls
  final RxBool isLoading = false.obs;

  // Payment due type
  final paymentDue = 'Net 30'.obs;

  // Memo
  final memoController = TextEditingController();

  // Tax rate
  final taxRate = 5.0.obs;

  // New item form controllers
  final newDescriptionController = TextEditingController();
  final newQtyController = TextEditingController();
  final newPriceController = TextEditingController();
  final newTaxController = TextEditingController();

  // Clients list
  final clients = <Client>[].obs;
  final RxBool _isFetchingClients = false.obs;
  bool get isFetchingClients => _isFetchingClients.value;

  // Real Invoices List
  final fetchedInvoices = <NewInvoiceModel>[].obs;
  final RxBool _isFetchingInvoices = false.obs;
  bool get isFetchingInvoices => _isFetchingInvoices.value;

  @override
  void onInit() {
    super.onInit();
    fetchClients();
    fetchInvoices();
  }

  @override
  void onClose() {
    memoController.dispose();
    newDescriptionController.dispose();
    newQtyController.dispose();
    newPriceController.dispose();
    newTaxController.dispose();
    super.onClose();
  }

  void changeTab(String active) {
    activeTab.value = active;
  }

  // Computed values
  double get subtotal {
    double total = 0;
    for (final item in items) {
      total += item.total;
    }
    return total;
  }

  double get calculatedTax => subtotal * (taxRate.value / 100);

  double get grandTotal => subtotal + calculatedTax;

  // Format date
  String get formattedDate {
    final d = invoiceDate.value;
    final month = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    final year = d.year;
    return '$month-$day-$year';
  }

  // Add item
  void addItem(String description, int qty, double price, double tax) {
    if (description.isEmpty) return;
    items.add(
      InvoiceItem(
        description: description,
        quantity: qty,
        price: price,
        taxPercent: tax,
      ),
    );
    newDescriptionController.clear();
    newQtyController.clear();
    newPriceController.clear();
    newTaxController.clear();
  }

  // Remove item
  void removeItem(int index) {
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
    }
  }

  // Toggle template save
  void toggleSaveAsTemplate() {
    saveAsTemplate.value = !saveAsTemplate.value;
  }

  // Select client
  void selectClient(String client) {
    selectedClient.value = client;
  }

  // Change currency
  void changeCurrency(String currency) {
    selectedCurrency.value = currency;
  }

  // Pick date
  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: invoiceDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF3B82F6),
              surface: Color(0xFF1E293B),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      invoiceDate.value = picked;
    }
  }

  // Fetch clients from API
  Future<void> fetchClients() async {
    _isFetchingClients.value = true;
    try {
      final response = await Get.find<AppApiClient>().dio.get('/clients');
      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw Exception('Invalid server response');
      }

      final items = data['items'];
      if (items is! List) {
        throw Exception('Invalid server response');
      }

      final fetchedClients = items
          .map((e) => Client.fromJson(e as Map<String, dynamic>))
          .toList();
      clients.assignAll(fetchedClients);
    } catch (e) {
      debugPrint('Error fetching clients: $e');
    } finally {
      _isFetchingClients.value = false;
    }
  }

  // Fetch real invoices from API
  Future<void> fetchInvoices() async {
    _isFetchingInvoices.value = true;
    try {
      final repository = Get.put(NewInvoiceRepository());
      final items = await repository.listInvoices();
      fetchedInvoices.assignAll(items);
    } catch (e) {
      debugPrint('Error fetching invoices: $e');
    } finally {
      _isFetchingInvoices.value = false;
    }
  }
}
