import 'package:get/get.dart';
import 'package:billkit/core/utils/snack_helper.dart';
import 'package:billkit/features/settlement_methods/data/models/payout_method_model.dart';
import 'package:billkit/features/settlement_methods/data/repositories/payout_methods_repository.dart';

class SettingsController extends GetxController {
  final PayoutMethodsRepository _payoutRepo = Get.put(PayoutMethodsRepository());

  // SECURITY & ACCESS
  final biometricAuth = true.obs;
  final keySync = false.obs;

  // WORKSPACE
  final gridMeshOverlay = true.obs;
  final highContrastMode = false.obs;
  final telemetry = true.obs;

  // PAYOUT METHODS
  final RxList<PayoutMethodModel> payoutMethods = <PayoutMethodModel>[].obs;
  final isLoadingPayouts = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPayoutMethods();
  }

  Future<void> fetchPayoutMethods() async {
    isLoadingPayouts.value = true;
    try {
      final methods = await _payoutRepo.getPayoutMethods();
      payoutMethods.value = methods;
    } catch (e) {
      SnackHelper.showError('Failed to load payout channels');
    } finally {
      isLoadingPayouts.value = false;
    }
  }

  void toggleBiometricAuth() => biometricAuth.toggle();
  void toggleKeySync() => keySync.toggle();
  void toggleGridMesh() => gridMeshOverlay.toggle();
  void toggleHighContrast() => highContrastMode.toggle();
  void toggleTelemetry() => telemetry.toggle();
}
