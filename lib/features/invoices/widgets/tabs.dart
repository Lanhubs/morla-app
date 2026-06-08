import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/features/invoices/controllers/invoices_controller.dart';

class InvoiceTabs extends StatelessWidget {
  final  controller = Get.put(InvoicesController());
   InvoiceTabs({super.key, });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            _TabButton(
              label: 'Edit',
              isActive: controller.activeTab.value == 'edit',
              onTap: () => controller.changeTab('edit'),
            ),
            _TabButton(
              label: 'Preview',
              isActive: controller.activeTab.value == 'preview',
              onTap: () => controller.changeTab('preview'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF3B82F6) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
