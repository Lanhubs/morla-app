import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/features/invoices/controllers/invoices_controller.dart';
import 'client_item.dart';

class ClientPickerBottomSheet extends StatelessWidget {
  final InvoicesController controller;

  const ClientPickerBottomSheet({super.key, required this.controller});

  static Future<void> show(
    BuildContext context,
    InvoicesController controller,
  ) {
    return Get.bottomSheet(
      ClientPickerBottomSheet(controller: controller),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF222B3B)),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select a client...',
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFF334155)),

            // Fetching state
            Obx(() {
              if (controller.isFetchingClients) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
                  ),
                );
              }

              // Clients List
              if (controller.clients.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      'No clients found',
                      style: TextStyle(
                        color: const Color(0xFF94A3B8),
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }

              return Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.clients.length,
                  itemBuilder: (context, index) {
                    final client = controller.clients[index];
                    return ClientItem(client: client, controller: controller);
                  },
                ),
              );
            }),

            const Divider(height: 1, color: Color(0xFF334155)),

            // Add New Client Button
            InkWell(
              onTap: () {
                // Navigate to new client view
                Get.toNamed('/new-client');
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                alignment: Alignment.center,
                child: const Text(
                  'Add New Client',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
