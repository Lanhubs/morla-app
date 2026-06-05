import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/features/invoices/controllers/invoices_controller.dart';

class CurrencySection extends StatelessWidget {
  final InvoicesController controller;
  const CurrencySection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'Currency',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '*',
              style: TextStyle(
                color: Color(0xFF3B82F6),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(14),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: controller.selectedCurrency.value,
                isExpanded: true,
                dropdownColor: const Color(0xFF1E293B),
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF94A3B8),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                items: controller.currencies.map((currency) {
                  return DropdownMenuItem<String>(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.changeCurrency(value);
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
