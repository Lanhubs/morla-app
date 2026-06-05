import 'package:flutter/material.dart';
import 'package:morla/core/widgets/cta_button.dart';

class AddItemActionButtons extends StatelessWidget {
  final bool isProcessing;
  final VoidCallback onCancel;
  final VoidCallback onAddItem;

  const AddItemActionButtons({
    super.key,
    required this.isProcessing,
    required this.onCancel,
    required this.onAddItem,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CtaButton(
            text: "Cancel",
            onPressed: isProcessing ? null : onCancel,
            type: CtaButtonType.outlined,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: CtaButton(
            text: isProcessing ? "Adding..." : "Add Item",
            onPressed: isProcessing ? null : onAddItem,
            type: CtaButtonType.primary,
          ),
        ),
      ],
    );
  }
}
