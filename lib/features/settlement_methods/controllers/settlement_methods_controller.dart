import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/core/utils/snack_helper.dart';
import 'package:morla/features/settlement_methods/data/models/payout_method_model.dart';
import 'package:morla/features/settlement_methods/data/repositories/payout_methods_repository.dart';
import 'package:morla/features/settlement_methods/view/widgets/edit_method_sheet.dart';

class SettlementMethodsController extends GetxController {
  final PayoutMethodsRepository _repository;

  SettlementMethodsController({PayoutMethodsRepository? repository})
    : _repository = repository ?? PayoutMethodsRepository();

  final isLoading = false.obs;
  final fiatMethods = <PayoutMethodModel>[].obs;
  final cryptoMethods = <PayoutMethodModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMethods();
  }

  Future<void> fetchMethods() async {
    isLoading.value = true;
    try {
      final methods = await _repository.getPayoutMethods();
      fiatMethods.assignAll(methods.where((m) => m.methodType == 'bank'));
      cryptoMethods.assignAll(methods.where((m) => m.methodType == 'crypto'));
    } catch (e) {
      SnackHelper.showError(
        "Failed to load settlement methods: $e",
        title: "Error",
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Edit action
  void editMethod(PayoutMethodModel method) {
    EditMethodSheet.show(method, this);
  }

  // Sync / Add new action
  void syncGatewayConfig() {
    debugPrint("Syncing Gateway Config...");
  }
}
