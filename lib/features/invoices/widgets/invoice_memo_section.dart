import 'package:flutter/material.dart';
import 'package:billkit/features/invoices/controllers/invoices_controller.dart';

class InvoiceMemoSection extends StatelessWidget {
  final InvoicesController controller;
  const InvoiceMemoSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'INVOICE MEMO',
          style: TextStyle(
            color: Color(0xFF64748B),
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(14),
          ),
          child: TextField(
            controller: controller.memoController,
            maxLines: 3,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
            decoration: InputDecoration(
              hintText: 'Write a note to the client...',
              hintStyle: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 13,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(16),
              fillColor: Colors.transparent,
              filled: true,
            ),
          ),
        ),
      ],
    );
  }
}
