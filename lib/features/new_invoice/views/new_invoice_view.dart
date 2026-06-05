import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/features/new_invoice/controllers/new_invoice_controller.dart';
import 'package:morla/features/new_invoice/widgets/invoice_preview_tab.dart';

import 'package:morla/features/new_invoice/widgets/new_invoice_form.dart';
import 'package:morla/features/invoices/widgets/tabs.dart';

class NewInvoiceView extends StatelessWidget {
  const NewInvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewInvoiceController());
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: 50,
          ),
          child: Column(
            children: [
              // Title
              const Text(
                'Create Invoice',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              // Edit / Preview tabs
              InvoiceTabs(),
              const SizedBox(height: 16),
              Expanded(
                child: Obx(
                  () => controller.activeTab.value == 'edit'
                      ? NewInvoiceForm(controller: controller)
                      : InvoicePreviewTab(controller: controller),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
