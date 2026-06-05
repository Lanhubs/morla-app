import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/widgets.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () => Column(
              children: [
                Header(),

                SizedBox(height: 32),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 16,
                    children: [
                      MetricCard(
                        title: "Total Invoices",
                        value: controller.totalInvoices.value.toString(),
                        icon: HugeIcons.strokeRoundedInvoice03,
                      ),
                      MetricCard(
                        title: "Total Paid",
                        value:
                            "\$ ${controller.totalPaid.value.toStringAsFixed(2)}",
                        icon: HugeIcons.strokeRoundedMoneyBag02,
                      ),
                      MetricCard(
                        title: "Total Unpaid",
                        value:
                            "\$ ${controller.totalUnpaid.value.toStringAsFixed(2)}",
                        status: "unpaid",
                        icon: HugeIcons.strokeRoundedMoneyBag02,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                ActionButtons(),
                SizedBox(height: 20),
                RecentInvoices(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
