import 'package:flutter/material.dart';
import 'package:morla/core/widgets/input.dart';

class AddTaxSection extends StatelessWidget {
  const AddTaxSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Input(
      label: "Tax Rate",
      hintText: "5.0",
      suffixText: "%",
    );
  }
}