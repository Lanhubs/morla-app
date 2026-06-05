import 'package:get/get.dart';

class SettingsController extends GetxController {
  // SECURITY & ACCESS
  final biometricAuth = true.obs;
  final keySync = false.obs;

  // WORKSPACE
  final gridMeshOverlay = true.obs;
  final highContrastMode = false.obs;
  final telemetry = true.obs;

  void toggleBiometricAuth() => biometricAuth.toggle();
  void toggleKeySync() => keySync.toggle();
  void toggleGridMesh() => gridMeshOverlay.toggle();
  void toggleHighContrast() => highContrastMode.toggle();
  void toggleTelemetry() => telemetry.toggle();
}
