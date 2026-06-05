import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/core/theme/app_colors.dart';
import 'filter_dropdown.dart';
import 'history_date_range_sheet.dart';
import 'history_filter_date_slot.dart';

class HistoryFilters extends StatelessWidget {
  final DateTime? fromDate;
  final DateTime? toDate;
  final void Function(DateTime? from, DateTime? to) onDateRangeChanged;
  final VoidCallback onClearDateRange;
  final String selectedStatus;
  final List<String> statuses;
  final Function(String) onStatusChanged;

  const HistoryFilters({
    super.key,
    required this.fromDate,
    required this.toDate,
    required this.onDateRangeChanged,
    required this.onClearDateRange,
    required this.selectedStatus,
    required this.statuses,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final hasRange = fromDate != null || toDate != null;

    return SizedBox(
      height: 52,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () async {
                final range = await Get.bottomSheet<DateTimeRange?>(
                  HistoryDateRangeSheet(
                    initialFromDate: fromDate,
                    initialToDate: toDate,
                  ),
                  isScrollControlled: true,
                  backgroundColor: const Color(0xFF101827),
                  clipBehavior: Clip.antiAlias,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    side: BorderSide.none,
                  ),
                );

                if (range != null) {
                  onDateRangeChanged(range.start, range.end);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF111827).withValues(alpha: 0.65),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_rounded,
                      size: 18,
                      color: AppColors.textMutedDark,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: HistoryFilterDateSlot(
                              title: 'From',
                              value: fromDate == null
                                  ? 'Select'
                                  : historyFilterDateText(
                                      fromDate!,
                                      compact: true,
                                    ),
                              active: fromDate != null,
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 24,
                            color: Colors.white.withValues(alpha: 0.08),
                          ),
                          Expanded(
                            child: HistoryFilterDateSlot(
                              title: 'To',
                              value: toDate == null
                                  ? 'Select'
                                  : historyFilterDateText(
                                      toDate!,
                                      compact: true,
                                    ),
                              active: toDate != null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (hasRange)
                      InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: onClearDateRange,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue.withValues(
                              alpha: 0.14,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            size: 14,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      )
                    else
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 18,
                        color: Colors.white.withValues(alpha: 0.75),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          FilterDropdown(
            value: selectedStatus,
            items: statuses,
            onChanged: onStatusChanged,
            highlighted: selectedStatus != 'All Status',
          ),
        ],
      ),
    );
  }
}
