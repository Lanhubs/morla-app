import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:morla/core/services/app_api_client.dart';
import 'package:morla/core/utils/snack_helper.dart';
import 'package:morla/features/clients/data/models/client_model.dart';

class NewClientController extends GetxController {
  final AppApiClient _apiClient;

  NewClientController({AppApiClient? apiClient})
    : _apiClient = apiClient ?? Get.find<AppApiClient>();

  // Text controllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController taxIdController = TextEditingController();
  final TextEditingController paymentTermsController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  // Loading state
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  // Error state
  final RxString _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  @override
  void onClose() {
    // Dispose all controllers when controller is closed
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    companyController.dispose();
    jobTitleController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    countryController.dispose();
    taxIdController.dispose();
    paymentTermsController.dispose();
    notesController.dispose();
    super.onClose();
  }

  // Clear the form
  void clearForm() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    companyController.clear();
    jobTitleController.clear();
    addressController.clear();
    cityController.clear();
    stateController.clear();
    zipCodeController.clear();
    countryController.clear();
    taxIdController.clear();
    paymentTermsController.clear();
    notesController.clear();
    _errorMessage.value = '';
    
  }

  // Validate form
  bool _validateForm() {
    _errorMessage.value = '';

    if (nameController.text.isEmpty) {
      _errorMessage.value = 'Please enter client name';
      return false;
    }

    if (emailController.text.isEmpty) {
      _errorMessage.value = 'Please enter email address';
      return false;
    }

    // Basic email validation
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(emailController.text)) {
      _errorMessage.value = 'Please enter a valid email address';
      return false;
    }

    if (phoneController.text.isEmpty) {
      _errorMessage.value = 'Please enter phone number';
      return false;
    }

    return true;
  }

  // Save client
  Future<void> saveClient() async {
    if (!_validateForm()) {
      SnackHelper.showError(errorMessage, title: "Validation Error");

      
      return;
    }

    _isLoading.value = true;

    try {
      // Create client data
      final clientData = {
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'company': companyController.text,
        'jobTitle': jobTitleController.text,
        'address': addressController.text,
        'city': cityController.text,
        'state': stateController.text,
        'zipCode': zipCodeController.text,
        'country': countryController.text,
        'taxId': taxIdController.text,
        'paymentTerms': paymentTermsController.text,
        'notes': notesController.text,
      };

      // Call API
      final response = await _apiClient.dio.post('/clients', data: clientData);

      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw Exception('Invalid server response');
      }

      final createdClient = Client.fromJson(data);

      // Show success message using backend response
      final successMessage = data['message'] ?? 'Client saved successfully';
      SnackHelper.showSuccess(successMessage);

     

      // Clear form after successful save
      clearForm();

      // Navigate back with result
      await Future.delayed(const Duration(milliseconds: 500));
      Get.back(result: createdClient);
    } catch (e) {
      debugPrint("error: $e");
      // Extract error message from backend response
      String errorMessage = 'Failed to save client. Please try again.';

      if (e is DioException) {
        final backendMessage = e.response?.data?['message'];
        if (backendMessage != null) {
          errorMessage = backendMessage.toString();
        }
      } else if (e.toString().isNotEmpty) {
        errorMessage = e.toString();
      }
      SnackHelper.showError(errorMessage, title: "Error");

     
    } finally {
      _isLoading.value = false;
    }
  }

  // Load client data (for editing)
  Future<void> loadClient(String clientId) async {
    _isLoading.value = true;

    try {
      final response = await _apiClient.dio.get('/clients/$clientId');
      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw Exception('Invalid server response');
      }

      final client = Client.fromJson(data);

      // Populate form with client data
      nameController.text = client.name;
      emailController.text = client.email;
      phoneController.text = client.phone;
      companyController.text = client.company;
      jobTitleController.text = client.jobTitle;
      addressController.text = client.address;
      cityController.text = client.city;
      stateController.text = client.state;
      zipCodeController.text = client.zipCode;
      countryController.text = client.country;
      taxIdController.text = client.taxId;
      paymentTermsController.text = client.paymentTerms;
      notesController.text = client.notes;

      _errorMessage.value = '';
    } catch (e) {
      // Extract error message from backend response
      String errorMessage = 'Failed to load client data';

      if (e is DioException) {
        final backendMessage = e.response?.data?['message'];
        if (backendMessage != null) {
          errorMessage = backendMessage.toString();
        }
      }

      _errorMessage.value = errorMessage;
            SnackHelper.showError(errorMessage, title: "Error");

      
    } finally {
      _isLoading.value = false;
    }
  }
}
