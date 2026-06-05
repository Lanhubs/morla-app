import 'package:flutter/material.dart';
import 'package:morla/features/clients/data/models/client_model.dart';
import 'client_card.dart';

class ClientsList extends StatelessWidget {
  final List<Client> clients;
  final Function(Client) onHistoryTap;
  final Function(Client) onDownloadTap;
  final Function(Client) onNotificationTap;
  final Function(Client) onCardTap;
  final EdgeInsets? padding;
  final double spacing;

  const ClientsList({
    super.key,
    required this.clients,
    required this.onHistoryTap,
    required this.onDownloadTap,
    required this.onNotificationTap,
    required this.onCardTap,
    this.padding,
    this.spacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: padding ?? const EdgeInsets.only(bottom: 100),
      itemCount: clients.length,
      separatorBuilder: (context, index) => SizedBox(height: spacing),
      itemBuilder: (context, index) {
        final Client client = clients[index];
        return ClientCard(
          client: client,
          onHistoryTap: () => onHistoryTap(client),
          onDownloadTap: () => onDownloadTap(client),
          onNotificationTap: () => onNotificationTap(client),
          onCardTap: () => onCardTap(client),
        );
      },
    );
  }
}
