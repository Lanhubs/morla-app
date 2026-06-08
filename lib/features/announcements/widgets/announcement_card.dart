import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/features/announcements/data/models/announcement_model.dart';
import 'package:billkit/features/announcements/controllers/announcements_controller.dart';
import 'package:billkit/features/announcements/widgets/announcement_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class AnnouncementCard extends StatelessWidget {
  final AnnouncementModel announcement;
  final VoidCallback? onTap;

  const AnnouncementCard({super.key, required this.announcement, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: announcement.read
              ? AppColors.darkSurfaceStroke
              : AppColors.primaryBlue.withValues(alpha: 0.3),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? () => _showAnnouncementDetails(),
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _AnnouncementHeader(),
                const SizedBox(height: 12),
                _AnnouncementMessage(),
                const SizedBox(height: 12),
                _AnnouncementFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _AnnouncementHeader() {
    return Row(
      children: [
        _PriorityIndicator(),
        const SizedBox(width: 8),
        if (!announcement.read) _UnreadDot(),
        if (!announcement.read) const SizedBox(width: 8),
        Expanded(
          child: Text(
            announcement.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: announcement.read ? FontWeight.w500 : FontWeight.bold,
              color: announcement.read ? AppColors.textMutedDark : Colors.white,
            ),
          ),
        ),
        _AnnouncementActions(),
      ],
    );
  }

  Widget _PriorityIndicator() {
    Color color;
    switch (announcement.priority.toLowerCase()) {
      case 'critical':
        color = AppColors.alertRed;
        break;
      case 'important':
        color = Colors.orange;
        break;
      default:
        color = AppColors.primaryBlue;
    }

    return Container(
      width: 4,
      height: 16,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _UnreadDot() {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: AppColors.primaryBlue,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _AnnouncementMessage() {
    return Text(
      announcement.message,
      style: TextStyle(
        fontSize: 14,
        color: announcement.read ? AppColors.textMutedDark : Colors.white70,
        height: 1.4,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _AnnouncementFooter() {
    return Row(
      children: [
        _AnnouncementTypeChip(),
        const Spacer(),
        _AnnouncementTime(),
        if (announcement.ctaEnabled) ...[
          const SizedBox(width: 8),
          _CTAButton(),
        ],
      ],
    );
  }

  Widget _AnnouncementTypeChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.darkCanvas,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.darkSurfaceStroke),
      ),
      child: Text(
        announcement.type.replaceAll('_', ' ').toUpperCase(),
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: AppColors.textMutedDark,
        ),
      ),
    );
  }

  Widget _AnnouncementTime() {
    final now = DateTime.now();
    final difference = now.difference(announcement.createdAt);

    String timeText;
    if (difference.inDays > 0) {
      timeText = '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      timeText = '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      timeText = '${difference.inMinutes}m ago';
    } else {
      timeText = 'Just now';
    }

    return Text(
      timeText,
      style: const TextStyle(fontSize: 12, color: AppColors.textMutedDark),
    );
  }

  Widget _CTAButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.3)),
      ),
      child: Text(
        announcement.ctaButtonText ?? 'View',
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryBlue,
        ),
      ),
    );
  }

  Widget _AnnouncementActions() {
    return PopupMenuButton<String>(
      icon: const HugeIcon(
        icon: HugeIcons.strokeRoundedMoreVertical,
        color: AppColors.textMutedDark,
        size: 18,
      ),
      color: AppColors.darkSurface,
      surfaceTintColor: Colors.transparent,
      itemBuilder: (context) => [
        if (!announcement.read)
          const PopupMenuItem<String>(
            value: 'mark_read',
            child: Row(
              children: [
                HugeIcon(
                  icon: HugeIcons.strokeRoundedTick01,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: 8),
                Text('Mark as read', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: Row(
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedDelete01,
                color: AppColors.alertRed,
                size: 16,
              ),
              SizedBox(width: 8),
              Text('Delete', style: TextStyle(color: AppColors.alertRed)),
            ],
          ),
        ),
      ],
      onSelected: (value) => _handleMenuAction(value),
    );
  }

  void _handleMenuAction(String action) {
    final controller = Get.find<AnnouncementsController>();

    switch (action) {
      case 'mark_read':
        controller.markAsRead(announcement.announcementId);
        break;
      case 'delete':
        controller.deleteAnnouncement(announcement.announcementId);
        break;
    }
  }

  void _showAnnouncementDetails() {
    // Mark as read when viewed
    if (!announcement.read) {
      final controller = Get.find<AnnouncementsController>();
      controller.markAsRead(announcement.announcementId);
    }

    Get.bottomSheet(
      AnnouncementBottomSheet(announcement: announcement),
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
    );
  }
}
