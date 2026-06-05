import 'package:flutter/material.dart';
import 'package:morla/features/invoices/controllers/invoices_controller.dart';
import 'add_item_action_buttons.dart';
import 'add_item_header.dart';
import 'package:morla/features/invoices/widgets/add_item_form.dart';

class AddItemBottomSheet extends StatefulWidget {
  final InvoicesController controller;

  const AddItemBottomSheet({super.key, required this.controller});

  /// STATIC RUNNER: Bypasses native container background artifacts completely
  static Future<void> show(
    BuildContext context,
    InvoicesController controller,
  ) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors
          .transparent, // FIX: Removes the underlying native background block
      elevation: 0, // FIX: Removes the default shadow conflict
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => AddItemBottomSheet(controller: controller),
    );
  }

  @override
  State<AddItemBottomSheet> createState() => _AddItemBottomSheetState();
}

class _AddItemBottomSheetState extends State<AddItemBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final _formKey = GlobalKey<FormState>();
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleAddItem(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isProcessing = true);

    await Future.delayed(const Duration(milliseconds: 300));

    final desc = widget.controller.newDescriptionController.text.trim();
    final qty = int.tryParse(widget.controller.newQtyController.text) ?? 1;
    final price =
        double.tryParse(widget.controller.newPriceController.text) ?? 0;
    final tax = double.tryParse(widget.controller.newTaxController.text) ?? 5;

    widget.controller.addItem(desc, qty, price, tax);

    if (context.mounted) {
      setState(() => _isProcessing = false);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFF0F1419),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Content
              Flexible(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AddItemHeader(onClose: () => Navigator.of(context).pop()),
                      const SizedBox(height: 24),
                      AddItemForm(controller: widget.controller),
                      const SizedBox(height: 32),
                      AddItemActionButtons(
                        isProcessing: _isProcessing,
                        onCancel: () => Navigator.of(context).pop(),
                        onAddItem: () => _handleAddItem(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
