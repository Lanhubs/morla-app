import 'package:flutter/material.dart';
import 'package:billkit/features/clients/data/models/client_model.dart';
import 'package:billkit/features/invoices/controllers/invoices_controller.dart';
import 'package:get/get.dart';

class ClientItem extends StatelessWidget {
  final Client client;
  final InvoicesController controller;

  const ClientItem({super.key, required this.client, required this.controller});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.selectClient(client.name);
        Get.back();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF26334D),
                shape: BoxShape.circle,
                image: client.avatarUrl.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(client.avatarUrl),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              alignment: Alignment.center,
              child: client.avatarUrl.isEmpty
                  ? Text(
                      client.name.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        color: Color(0xFF3B82F6),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    client.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    client.email,
                    style: const TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
