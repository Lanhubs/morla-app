import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:morla/core/utils/snack_helper.dart';
import 'package:morla/features/dashboard/data/repositories/dashboard_repository.dart';

class DashboardController extends GetxController {
  final DashboardRepository? _repository;

  DashboardController({DashboardRepository? repository})
    : _repository = repository;

  final totalInvoices = 0.obs;
  final totalPaid = 0.0.obs;
  final totalUnpaid = 0.0.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadDashboardStats();
  }

  Future<void> _loadDashboardStats() async {
    if (_repository == null) {
      // Default values for when repository is not available
      totalInvoices.value = 0;
      totalPaid.value = 0.0;
      totalUnpaid.value = 0.0;
      isLoading.value = false;
      return;
    }

    isLoading.value = true;
    try {
      final stats = await _repository.getDashboardStats();
      totalInvoices.value = stats.totalInvoices;
      totalPaid.value = stats.totalPaid;
      totalUnpaid.value = stats.totalUnpaid;
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
}
