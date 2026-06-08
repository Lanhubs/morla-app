import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:billkit/core/utils/snack_helper.dart';
import 'package:billkit/features/invoices/controllers/invoices_controller.dart';
import 'package:billkit/features/new_invoice/data/models/new_invoice_model.dart';
import 'package:billkit/features/new_invoice/data/repositories/new_invoice_repository.dart';
import 'package:billkit/features/new_invoice/widgets/bottom_sheets/settlement_options_bottom_sheet.dart'
    as import_sheet;
import 'package:billkit/features/settlement_methods/data/repositories/payout_methods_repository.dart';

class NewInvoiceController extends InvoicesController {
  final NewInvoiceRepository _repository;

  NewInvoiceController({NewInvoiceRepository? repository})
    : _repository = repository ?? NewInvoiceRepository(),
      super();

  // Loading state for creating invoice
  final RxBool _isCreating = false.obs;
  bool get isCreating => _isCreating.value;

  // Current invoice being edited (for update flow)
  NewInvoiceModel? currentInvoice;

  // Settlement Options State
  final activeSettlementTab = 'crypto'.obs;
  final selectedCryptoAsset = 'USDC'.obs;

  final isEnteringNewWallet = false.obs;
  final isEnteringNewFiatAccount = false.obs;

  final savedWallets = <String>[].obs;
  final savedFiatAccounts = <String>[].obs;

  final selectedWallet = ''.obs;
  final selectedFiatAccount = ''.obs;

  final isFetchingAccounts = false.obs;

  // Signature State
  final signatureImagePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSavedAccounts();
  }

  Future<void> fetchSavedAccounts() async {
    isFetchingAccounts.value = true;
    try {
      final repository = Get.put(PayoutMethodsRepository());
      final allMethods = await repository.getPayoutMethods();

      final wallets = allMethods
          .where((e) => e.methodType == 'crypto')
          .toList();
      savedWallets.assignAll(
        wallets
            .map((w) => w.walletAddress ?? '')
            .where((addr) => addr.isNotEmpty),
      );
      if (savedWallets.isNotEmpty &&
          !savedWallets.contains(selectedWallet.value)) {
        selectedWallet.value = savedWallets.first;
      }

      final banks = allMethods.where((e) => e.methodType == 'bank').toList();
      savedFiatAccounts.assignAll(
        banks
            .map((b) => '${b.bankName} - ${b.accountNumber}')
            .where((acc) => acc.isNotEmpty),
      );
      if (savedFiatAccounts.isNotEmpty &&
          !savedFiatAccounts.contains(selectedFiatAccount.value)) {
        selectedFiatAccount.value = savedFiatAccounts.first;
      }
    } catch (e) {
      debugPrint('Error fetching saved accounts: $e');
    } finally {
      isFetchingAccounts.value = false;
    }
  }

  // Save/create invoice
  Future<void> saveInvoice() async {
    if (selectedClient.value.isEmpty) {
      
      SnackHelper.showError(
        'Please select a client',
        title:'Validation Error',
        
        );
      return;
    }

    if (items.isEmpty) {
      SnackHelper.showError("Please add at least one item",title:  "Validation Error");
     
      return;
    }

    // Validation passed, show settlement options
    if (Get.context != null) {
      import_sheet.SettlementOptionsBottomSheet.show(Get.context!, this);
    }
  }

  Future<void> submitInvoice({
    required String settlementMethod,
    required String settlementAsset,
  }) async {
    _isCreating.value = true;
    try {
      final clientId = await _getClientIdByName(selectedClient.value);

      final invoiceData = NewInvoiceModel(
        clientId: clientId,
        clientName: selectedClient.value,
        clientEmail: '',
        clientPhone: '',
        clientAddress: '',
        clientCity: '',
        currency: selectedCurrency.value,
        invoiceDate: invoiceDate.value,
        dueDate: dueDate.value,
        items: items.toList(),
        taxRate: taxRate.value,
        paymentTerms: paymentDue.value,
        memo: memoController.text,
        subtotal: subtotal,
        taxAmount: calculatedTax,
        totalAmount: grandTotal,
        settlementMethod: settlementMethod,
        settlementAsset: settlementAsset,
      );

      final createdInvoice = await _repository.createInvoice(invoiceData);

      currentInvoice = createdInvoice;

      Get.back(); // close bottom sheet\
      SnackHelper.showSuccess('Invoice saved successfully', title: "Success");
    } catch (e) {
      debugPrint("Error saving invoice: $e");
      String errorMessage = 'Failed to save invoice';

      if (e is DioException) {
        final backendMessage = e.response?.data?['message'];
        if (backendMessage != null) {
          errorMessage = backendMessage.toString();
        }
      }
      SnackHelper.showError(errorMessage, title: "Error");
    } finally {
      _isCreating.value = false;
    }
  }

  // Load invoice data for editing
  Future<void> loadInvoice(String invoiceId) async {
    isLoading.value = true;
    try {
      final invoice = await _repository.getInvoice(invoiceId);
      if (invoice != null) {
        currentInvoice = invoice;

        // Populate form fields
        selectedClient.value = invoice.clientName;
        selectedCurrency.value = invoice.currency;
        invoiceDate.value = invoice.invoiceDate;
        dueDate.value = invoice.dueDate;
        items.assignAll(invoice.items);
        taxRate.value = invoice.taxRate;
        paymentDue.value = invoice.paymentTerms;
        memoController.text = invoice.memo;

        invoiceNumber.value =
            invoice.invoiceNumber ??
            '#INV-${invoice.id?.substring(0, 6).toUpperCase()}';
      }
    } catch (e) {
      String errorMessage = 'Failed to load invoice';

      if (e is DioException) {
        final backendMessage = e.response?.data?['message'];
        if (backendMessage != null) {
          errorMessage = backendMessage.toString();
        }
      }
      SnackHelper.showError(errorMessage, title: "Error");
    } finally {
      isLoading.value = false;
    }
  }

  // Helper to get client ID by name (simplified implementation)
  Future<String> _getClientIdByName(String clientName) async {
    try {
      final client = clients.firstWhere((c) => c.name == clientName);
      return client.id;
    } catch (e) {
      return '123e4567-e89b-12d3-a456-426614174000'; // valid fallback UUID
    }
  }

  Future<void> pickSignature() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      signatureImagePath.value = pickedFile.path;
    }
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
}
