import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/widgets.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<DashboardController>()
        ? Get.find<DashboardController>()
        : Get.put(DashboardController());

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => controller.refreshDashboardStats(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Header(), // Static structural widget -> Never flashes now!
                const SizedBox(height: 32),
                
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 16,
                    children: [
                      // Localized Obx just for the value change strings
                      Obx(() => MetricCard(
                        title: "Total Invoices",
                        value: controller.totalInvoices.value.toString(),
                        icon: HugeIcons.strokeRoundedInvoice03,
                      )),
                      Obx(() => MetricCard(
                        title: "Total Paid",
                        value: controller.formatCurrency(controller.totalPaid.value),
                        icon: HugeIcons.strokeRoundedMoneyBag02,
                      )),
                      Obx(() => MetricCard(
                        title: "Total Unpaid",
                        value: controller.formatCurrency(controller.totalUnpaid.value),
                        status: "unpaid",
                        icon: HugeIcons.strokeRoundedMoneyBag02,
                      )),
                    ],
                  ),
                ),
                
                const SizedBox(height: 25),
                ActionButtons(), // Static operational widget -> Never flashes now!
                const SizedBox(height: 20),
                
                // Isolate list updates completely inside its own reactive wrapper
                RecentInvoices(controller: controller),
              ],
            ),
          ),
        ),
      ),
    );
  }
}