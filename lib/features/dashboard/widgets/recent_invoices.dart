import 'package:billkit/features/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/widgets.dart';

class RecentInvoices extends StatelessWidget {
  final DashboardController controller;
  const RecentInvoices({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      spacing: 8,
      mainAxisSize: MainAxisSize.min, // Prevents column from overflowing
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recent Invoices",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "[View All]",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
       
          if (controller.recentInvoices.isEmpty) 
             Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                spacing: 16,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/empty-invoices.png",
                    width: 80,
                    height: 80,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                  const Text(
                    "No recent invoices",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            )else
           ListView.separated(
            shrinkWrap:
                true, // FIX: Forces the ListView to only take up needed space
            physics:
                const NeverScrollableScrollPhysics(), // FIX: Disables nested scrolling conflicts
            itemCount: controller.recentInvoices.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final invoice = controller.recentInvoices[index];
              return InvoiceCard(
                invoice: invoice,
                formatCurrency: controller.formatCurrency,
                formatDate: controller.formatDate,
                onTap: () => controller.viewInvoiceDetails(invoice),
              );
            },
          ),
       
       SizedBox(height: Get.height*0.05)
      ],
    ));
  }
}
