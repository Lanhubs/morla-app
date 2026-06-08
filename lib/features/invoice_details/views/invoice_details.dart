import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/features/invoice_details/controllers/invoice_details_controller.dart';
import 'package:billkit/features/invoice_details/widgets/automated_pings_section.dart';
import 'package:billkit/features/invoice_details/widgets/invoice_details_header.dart';
import 'package:billkit/features/invoice_details/widgets/invoice_info_grid.dart';
import 'package:billkit/features/invoice_details/widgets/service_itemization_section.dart';
import 'package:billkit/features/invoice_details/widgets/settlement_details_section.dart';
import 'package:billkit/features/invoice_details/widgets/share_invoice_button.dart';

class InvoiceDetailsView extends StatelessWidget {
  const InvoiceDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InvoiceDetailsController());
    return Scaffold(
      backgroundColor: AppColors.darkCanvas,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value && controller.invoice.value == null) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryBlue),
            );
          }
          if (controller.invoice.value == null) {
            return const Center(
              child: Text(
                'Invoice not found.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InvoiceDetailsHeader(),
                  SizedBox(height: 24),
                  InvoiceInfoGrid(),
                  SizedBox(height: 24),
                  ServiceItemizationSection(),
                  SizedBox(height: 24),
                  SettlementDetailsSection(),
                  SizedBox(height: 24),
                  AutomatedPingsSection(),
                  SizedBox(height: 24),
                  ShareInvoiceButton(),
                  SizedBox(height: 40),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

