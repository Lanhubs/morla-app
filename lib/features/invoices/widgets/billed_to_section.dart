import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/features/invoices/controllers/invoices_controller.dart';
import 'package:billkit/features/invoices/widgets/bottom_sheets/client_picker_bottom_sheet.dart';

class BilledToSection extends StatelessWidget {
  final InvoicesController controller;
  const BilledToSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(text: 'Billed To', isRequired: true),
        const SizedBox(height: 8),
        Obx(
          () => GestureDetector(
            onTap: () => _showClientPicker(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.selectedClient.value.isEmpty
                        ? 'Select a client...'
                        : controller.selectedClient.value,
                    style: TextStyle(
                      color: controller.selectedClient.value.isEmpty
                          ? const Color(0xFF94A3B8)
                          : Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF94A3B8),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showClientPicker(BuildContext context) {
    ClientPickerBottomSheet.show(context, controller);
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  final bool isRequired;

  const _SectionLabel({
    required this.text,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (isRequired)
          const Text(
            '*',
            style: TextStyle(
              color: Color(0xFF3B82F6),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}
