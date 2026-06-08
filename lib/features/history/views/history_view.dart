import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/widgets/search_input.dart';
import 'package:billkit/features/history/controllers/history_controller.dart';
import 'package:billkit/features/history/widgets/index.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const HistoryTitle(),
              const SizedBox(height: 24),

              // Search Bar
              SearchInput(
                hintText: 'Search clients...',
                controller: controller.searchController,
                onChanged: (value) => controller.filterInvoices(),
              ),
              const SizedBox(height: 20),

              // Filters Row
              Obx(
                () => HistoryFilters(
                  fromDate: controller.fromDate.value,
                  toDate: controller.toDate.value,
                  onDateRangeChanged: controller.updateDateRange,
                  onClearDateRange: controller.clearDateRange,
                  selectedStatus: controller.selectedStatus.value,
                  statuses: controller.statuses,
                  onStatusChanged: controller.selectStatus,
                ),
              ),
              const SizedBox(height: 24),

              // Invoice List
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const HistoryLoadingState();
                  }

                  if (controller.filteredInvoices.isEmpty) {
                    return const HistoryEmptyState();
                  }

                  return HistoryInvoiceList(
                    invoices: controller.filteredInvoices,
                    formatCurrency: controller.formatCurrency,
                    formatDate: controller.formatDate,
                    onInvoiceTap: controller.viewInvoiceDetails,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
