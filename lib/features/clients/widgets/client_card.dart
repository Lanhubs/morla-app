import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morla/features/clients/data/models/client_model.dart';
import 'action_button.dart';
import 'avatar_fallback.dart';
import 'glass_card.dart';
import 'status_tag.dart';

class ClientCard extends StatelessWidget {
  final Client client;
  final VoidCallback? onHistoryTap;
  final VoidCallback? onDownloadTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onCardTap;

  const ClientCard({
    super.key,
    required this.client,
    this.onHistoryTap,
    this.onDownloadTap,
    this.onNotificationTap,
    this.onCardTap,
  });

  String _formatCurrency(double value) {
    final parts = value.toStringAsFixed(0).split('.');
    final clean = parts[0];
    final regex = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    final formatted = clean.replaceAllMapped(regex, (Match m) => '${m[1]},');
    return '\$$formatted';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top section: Avatar, Name, Email, Status
            Row(
              children: [
                // Avatar
                _buildAvatar(),
                const SizedBox(width: 16),
                // Name & Email
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        client.name,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        client.email,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          color: const Color(0xFF8E9296),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Status Tag
                StatusTag.fromStatus(client.status),
              ],
            ),
            const SizedBox(height: 16),
            // Bottom section: Revenue & Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Revenue
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'REVENUE',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF8E9296),
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatCurrency(client.revenue),
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:  Colors.white,
                      ),
                    ),
                  ],
                ),
                // Action Buttons
                Row(
                  children: [
                    ActionButton(
                      icon: Icons.history,
                      onTap: onHistoryTap ?? () {},
                    ),
                    const SizedBox(width: 12),
                    ActionButton(
                      icon: HugeIcons.strokeRoundedDownload01,
                      onTap: onDownloadTap ?? () {},
                    ),
                    const SizedBox(width: 12),
                    ActionButton(
                      icon: HugeIcons.strokeRoundedNotification01,
                      onTap: onNotificationTap ?? () {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    if (client.avatarUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 48,
          height: 48,
          color: const Color(0xFF1E2024),
          child: Image.network(
            client.avatarUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return AvatarFallback(name: client.name);
            },
          ),
        ),
      );
    }

    return AvatarFallback(name: client.name);
  }
}
