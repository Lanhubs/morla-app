import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/core/utils/snack_helper.dart';
import 'package:morla/features/settlement_methods/data/repositories/payout_methods_repository.dart';
import 'package:morla/features/settlement_methods/data/models/payout_method_model.dart';

class PaymentSetupController extends GetxController {
  final PayoutMethodsRepository _repository = Get.put(
    PayoutMethodsRepository(),
  );

  final accountNumber = "".obs;
  final accountName = "".obs;
  final bankName = "".obs;

  final walletAddress = "".obs;
  final walletNetwork = "Ethereum".obs;

  Future<void> addNewAccount() async {
    try {
      if (bankName.value.isEmpty ||
          accountNumber.value.isEmpty ||
          accountName.value.isEmpty) {
        SnackHelper.showError(
          'Please fill in all bank details',
          title: "Error",
        );

        return;
      }

      final model = PayoutMethodModel(
        id: '', // Backend handles ID generation
        methodType: 'bank',
        label: bankName.value,
        isDefault: false,
        accountName: accountName.value,
        accountNumber: accountNumber.value,
        bankName: bankName.value,
        createdAt: DateTime.now(),
      );

      await _repository.createPayoutMethod(model);
      SnackHelper.showSuccess(
        'Bank account added successfully',
        title: "Success",
      );

      // Clear fields
      accountNumber.value = "";
      accountName.value = "";
      bankName.value = "";

      Get.back();
    } catch (e) {
      debugPrint("error adding account: $e");
      SnackHelper.showError("Failed to add account: ", title: "Error");
    }
  }

  Future<void> bindWallet() async {
    try {
      if (walletAddress.value.isEmpty) {
        SnackHelper.showError("Please enter a wallet address", title: "Error");

        return;
      }

      final model = PayoutMethodModel(
        id: '', // Backend handles ID generation
        methodType: 'crypto',
        label: '${walletNetwork.value} Wallet',
        isDefault: false,
        walletNetwork: walletNetwork.value,
        walletAddress: walletAddress.value,
        createdAt: DateTime.now(),
      );

      await _repository.createPayoutMethod(model);
      SnackHelper.showSuccess("Wallet bound successfully", title: "Success");

      // Clear fields
      walletAddress.value = "";

      Get.back();
    } catch (e) {
      SnackHelper.showError(
        "Failed to bind wallet: ${e.toString()}",
        title: "Error",
      );
    }
  }
}
