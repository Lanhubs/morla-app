import 'package:flutter/material.dart';
import 'package:morla/core/widgets/cta_button.dart';

class ActionBtns extends StatelessWidget {
  final bool isProcessing;
  final VoidCallback? onCancel;
  final VoidCallback? onAdd;

  const ActionBtns({
    super.key,
    required this.isProcessing,
    this.onCancel,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CtaButton(
            text: "Cancel",
            onPressed: isProcessing
                ? null
                : (onCancel ?? () => Navigator.of(context).pop()),
            type: CtaButtonType.outlined,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: CtaButton(
            text: isProcessing ? "Adding..." : "Add Item",
            onPressed: isProcessing ? null : (onAdd ?? () {}),
            type: CtaButtonType.primary,
          ),
        ),
      ],
    );
  }
}
