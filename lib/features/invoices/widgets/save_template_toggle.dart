import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/features/invoices/controllers/invoices_controller.dart';

class SaveTemplateToggle extends StatelessWidget {
  final InvoicesController controller;
  const SaveTemplateToggle({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.bookmark_outline_rounded,
                color: Color(0xFF3B82F6),
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Save as Client Template',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 28,
              child: Switch(
                value: controller.saveAsTemplate.value,
                onChanged: (_) => controller.toggleSaveAsTemplate(),
                activeThumbColor: const Color(0xFF3B82F6),
                activeTrackColor: const Color(
                  0xFF3B82F6,
                ).withValues(alpha: 0.4),
                inactiveThumbColor: const Color(0xFF94A3B8),
                inactiveTrackColor: const Color(0xFF1E293B),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
