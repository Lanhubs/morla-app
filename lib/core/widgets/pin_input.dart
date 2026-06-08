import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/core/theme/app_theme.dart';

class PinInput extends StatelessWidget {
  final int length;
  final String? label;
  final Function(String) onChanged;
  final Function(String)? onCompleted;
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;

  const PinInput({
    super.key,
    this.length = 4,
    this.label,
    required this.onChanged,
    this.onCompleted,
    required this.controllers,
    required this.focusNodes,
  });

  void _handleChange(int index, String value) {
    if (value.isNotEmpty) {
      // Move to next field if value is entered
      if (index < length - 1) {
        focusNodes[index + 1].requestFocus();
      } else {
        // All fields filled - call onCompleted
        String pin = controllers.map((c) => c.text).join();
        onCompleted?.call(pin);
      }
    }

    // Notify parent of change
    String pin = controllers.map((c) => c.text).join();
    onChanged(pin);
  }

  void _handleBackspace(int index, String value) {
    if (value.isEmpty && index > 0) {
      // Move to previous field on backspace if current is empty
      focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              label!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 6.0,
          children: List.generate(
            length,
            (index) => Flexible(
              child: AspectRatio(
                aspectRatio: 1.0,
                child: TextField(
                  
                  controller: controllers[index],
                  focusNode: focusNodes[index],
                  textAlign: TextAlign.center,
                  
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                decoration: InputDecoration(
                  counterText: '',
                  fillColor: Color(0xFF1E293B),

                  contentPadding: EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppThemes.componentRadius,
                    ),
                    borderSide: const BorderSide(
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppThemes.componentRadius,
                    ),
                    borderSide: const BorderSide(
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppThemes.componentRadius,
                    ),
                    borderSide: const BorderSide(
                      color: AppColors.primaryBlue,
                      width: 2,
                    ),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
                onChanged: (value) {
                  _handleChange(index, value);
                  _handleBackspace(index, value);
                },
              ),
            ),
          ),
          ),
        ),
      ],
    );
  }
}
