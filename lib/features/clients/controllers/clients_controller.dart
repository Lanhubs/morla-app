import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:billkit/core/services/app_api_client.dart';
import 'package:billkit/core/utils/snack_helper.dart';
import 'package:billkit/features/clients/data/models/client_model.dart';

class ClientsController extends GetxController {
  final AppApiClient _apiClient;

  ClientsController({AppApiClient? apiClient})
    : _apiClient = apiClient ?? Get.find<AppApiClient>();

  final RxList<Client> clients = <Client>[].obs;
  final RxList<Client> filteredClients = <Client>[].obs;
  final RxBool isLoading = false.obs;

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchClients();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void _onSearchChanged() {
    filterClients(searchController.text);
  }

  Future<void> fetchClients({String? search}) async {
    isLoading.value = true;
    try {
      final response = await _apiClient.dio.get(
        '/clients',
        queryParameters: search != null ? {'search': search} : null,
      );

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
      filterClients(searchController.text);
    } catch (e) {
      String errorMessage = 'Failed to fetch clients';

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

  void filterClients(String query) {
    if (query.trim().isEmpty) {
      filteredClients.assignAll(clients);
    } else {
      final q = query.toLowerCase();
      filteredClients.assignAll(
        clients.where((client) {
          return client.name.toLowerCase().contains(q) ||
              client.email.toLowerCase().contains(q) ||
              client.company.toLowerCase().contains(q);
        }).toList(),
      );
    }
  }
}
