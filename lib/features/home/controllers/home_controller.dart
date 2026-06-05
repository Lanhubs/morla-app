import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/features/clients/views/clients_view.dart';
import 'package:morla/features/dashboard/views/dashboard_view.dart';
import 'package:morla/features/history/views/history_view.dart';
import 'package:morla/features/settings/views/settings_view.dart';

class HomeController extends GetxController {
  final RxInt currentIndex = 0.obs;
  void changeTab(int index) {
    currentIndex.value = index;
    update();
  }
  List<Widget> get tabs => [
    const DashboardView(),
    const ClientsView(),
    const HistoryView(),
    const SettingsView(),
  ];

}