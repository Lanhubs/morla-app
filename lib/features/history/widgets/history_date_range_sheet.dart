import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/core/widgets/cta_button.dart';

class HistoryDateRangeSheetController extends GetxController {
  final DateTime? initialFromDate;
  final DateTime? initialToDate;

  HistoryDateRangeSheetController({this.initialFromDate, this.initialToDate});

  final Rxn<DateTime> fromDate = Rxn<DateTime>();
  final Rxn<DateTime> toDate = Rxn<DateTime>();
  final RxBool isSelectingFrom = true.obs;

  @override
  void onInit() {
    super.onInit();
    fromDate.value = initialFromDate;
    toDate.value = initialToDate;
    isSelectingFrom.value = fromDate.value == null;
  }

  DateTime get currentSelection {
    return toDate.value ?? fromDate.value ?? DateTime.now();
  }

  void selectFromMode() => isSelectingFrom.value = true;
  void selectToMode() => isSelectingFrom.value = false;

  void onDateChanged(DateTime pickedDate) {
    if (isSelectingFrom.value) {
      fromDate.value = pickedDate;
      if (toDate.value != null && toDate.value!.isBefore(fromDate.value!)) {
        toDate.value = fromDate.value;
      }
      isSelectingFrom.value = false;
      return;
    }

    if (fromDate.value == null) {
      fromDate.value = pickedDate;
      return;
    }

    if (pickedDate.isBefore(fromDate.value!)) {
      final previousFrom = fromDate.value!;
      fromDate.value = pickedDate;
      toDate.value = previousFrom;
    } else {
      toDate.value = pickedDate;
    }
  }

  void close() => Get.back();

  void submit() {
    if (fromDate.value == null) return;
    Get.back(
      result: DateTimeRange(
        start: fromDate.value!,
        end: toDate.value ?? fromDate.value!,
      ),
    );
  }
}

class HistoryDateRangeSheet extends StatelessWidget {
  final DateTime? initialFromDate;
  final DateTime? initialToDate;

  const HistoryDateRangeSheet({
    super.key,
    this.initialFromDate,
    this.initialToDate,
  });

  @override
  Widget build(BuildContext context) {
    return GetX<HistoryDateRangeSheetController>(
      init: HistoryDateRangeSheetController(
        initialFromDate: initialFromDate,
        initialToDate: initialToDate,
      ),
      builder: (controller) {
        return ColoredBox(
          color: const Color(0xFF101827),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                 
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _SheetDateSlot(
                          label: controller.fromDate.value == null
                              ? 'From'
                              : 'From  ${_dateText(controller.fromDate.value!)}',
                          active: controller.isSelectingFrom.value,
                          onTap: controller.selectFromMode,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _SheetDateSlot(
                          label: controller.toDate.value == null
                              ? 'To'
                              : 'To  ${_dateText(controller.toDate.value!)}',
                          active: !controller.isSelectingFrom.value,
                          onTap: controller.selectToMode,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.dark(
                        primary: AppColors.primaryBlue,
                        surface: Color(0xFF101827),
                        onSurface: Colors.white,
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    child: CalendarDatePicker(
                      key: ValueKey(
                        '${controller.currentSelection.year}-${controller.currentSelection.month}-${controller.currentSelection.day}',
                      ),
                      initialDate: controller.currentSelection,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2035),
                      onDateChanged: controller.onDateChanged,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CtaButton(
                          onPressed: controller.close,
                          text: 'Close',
                          type: CtaButtonType.secondary,
                          radius: RadiusType.regular,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CtaButton(
                          onPressed: controller.fromDate.value == null
                              ? null
                              : controller.submit,
                          text: 'Continue',
                          type: CtaButtonType.primary,
                          radius: RadiusType.regular,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SheetDateSlot extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _SheetDateSlot({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: active
                ? AppColors.primaryBlue.withValues(alpha: 0.7)
                : Colors.white.withValues(alpha: 0.08),
            width: active ? 1.3 : 1,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

String _dateText(DateTime date) {
  const monthsShort = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  return '${monthsShort[date.month - 1]} ${date.day}, ${date.year}';
}
