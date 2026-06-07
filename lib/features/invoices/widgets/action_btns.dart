import 'package:flutter/widgets.dart';
import 'package:morla/core/widgets/cta_button.dart';
import 'package:get/get.dart';

class ActionBtns extends StatelessWidget {
  final bool isProcessing;
  final VoidCallback handleAddItem;
  const ActionBtns({
    super.key,
    required this.handleAddItem,
    required this.isProcessing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CtaButton(
            text: "Cancel",
            onPressed: isProcessing ? null : () => Get.back(),
            type: CtaButtonType.outlined,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: CtaButton(
            text: isProcessing ? "Adding..." : "Add Item",
            onPressed: isProcessing ? null : () => handleAddItem(),
            type: CtaButtonType.primary,
          ),
        ),
      ],
    );
    ;
  }
}
