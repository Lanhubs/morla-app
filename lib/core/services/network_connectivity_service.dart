import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class NetworkConnectivityService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool _isBottomSheetOpen = false;

  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    // If ANY of the active connection types is something other than .none, we have a connection.
    final hasConnection = results.any((result) => result != ConnectivityResult.none);

    if (!hasConnection) {
      if (!_isBottomSheetOpen) {
        _isBottomSheetOpen = true;
        _showOfflineBottomSheet();
      }
    } else {
      if (_isBottomSheetOpen) {
        _isBottomSheetOpen = false;
        if (Get.isBottomSheetOpen ?? false) {
          Get.back(); // close the bottom sheet
        }
      }
    }
  }

  void _showOfflineBottomSheet() {
    Get.bottomSheet(
      PopScope(
        canPop: false, // Prevent dismissing by back button/swipe while offline
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          decoration: const BoxDecoration(
            color: Color(0xFF1E293B),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const HugeIcon(
                icon: HugeIcons.strokeRoundedWifiDisconnected01,
                color: Colors.redAccent,
                size: 64.0,
              ),
              const SizedBox(height: 24),
              const Text(
                'You are offline',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Please check your internet connection to continue using the app.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
    );
  }
}
