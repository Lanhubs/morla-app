import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/core/utils/snack_helper.dart';
import 'package:billkit/routes/app_routes.dart';
import 'package:billkit/features/clients/controllers/clients_controller.dart';
import 'package:billkit/features/clients/widgets/index.dart';

class ClientsView extends GetView<ClientsController> {
  const ClientsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background layers
        const ClientsBackground(),
        // Content Area
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search & Add Client Button
                ClientsSearchBar(
                  controller: controller.searchController,

                  onAddClient: () {
                    Get.toNamed(AppRoutes.newClient)?.then((value) {
                      if (value != null) {
                        controller.fetchClients();
                      }
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Header with Title and Filter
                const ClientsHeader(),
                const SizedBox(height: 16),

                // Client List
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const ClientsLoadingState();
                    }
                    if (controller.filteredClients.isEmpty) {
                      return ClientsEmptyState(
                        actionText: 'Add Your First Client',
                        onAction: () => Get.toNamed(AppRoutes.newClient),
                      );
                    }
                    return ClientsList(
                      clients: controller.filteredClients,
                      onHistoryTap: (client) {
                        // TODO: Implement history view
                        SnackHelper.showInfo(
                          'Viewing history for ${client.name}',
                          title: "History",
                        );
                      },
                      onDownloadTap: (client) {
                        // TODO: Implement download functionality
                        SnackHelper.showInfo(
                          "Downloading data for ${client.name}",
                          title: "Download",
                        );
                      },
                      onNotificationTap: (client) {
                        // TODO: Implement notification functionality
                        SnackHelper.showWarning(
                          "Sending notifications for ${client.name}",
                          title: "Notifications",
                        );

                       
                      },
                      onCardTap: (client) {
                        // TODO: Implement client details view
                        SnackHelper.showInfo(
                          "Opening details for ${client.name}",
                        );
                        
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
