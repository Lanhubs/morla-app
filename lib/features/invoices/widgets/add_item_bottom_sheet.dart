import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morla/core/theme/app_colors.dart';
import 'package:morla/core/widgets/cta_button.dart';
import 'package:morla/features/invoices/controllers/invoices_controller.dart';
import 'add_item_form.dart';
import 'action_btns.dart';

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

  Future<void> _handleAddItem() async {
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
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          height: Get.height * 0.57,
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 16,
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
            children: [
              // Content
              Flexible(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue.withValues(
                                alpha: 0.15,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const HugeIcon(
                              icon: HugeIcons.strokeRoundedPackage,
                              color: AppColors.primaryBlue,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Add Invoice Item',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    height: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Fill in the details below',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13,
                                    color: AppColors.textMutedDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(
                              Icons.close_rounded,
                              color: AppColors.textMutedDark,
                              size: 24,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      AddItemForm(controller: widget.controller),
                      const SizedBox(height: 32),
                      ActionBtns(
                        handleAddItem: _handleAddItem,
                        isProcessing: _isProcessing,
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
