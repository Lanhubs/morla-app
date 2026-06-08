import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/features/announcements/data/models/announcement_model.dart';
import 'package:billkit/features/announcements/controllers/announcements_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class AnnouncementBottomSheet extends StatelessWidget {
  final AnnouncementModel announcement;

  const AnnouncementBottomSheet({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DragHandle(),
          const SizedBox(height: 16),
          _AnnouncementHeader(announcement: announcement),
          const SizedBox(height: 16),
          _AnnouncementContent(announcement: announcement),
          const SizedBox(height: 24),
          _ActionButtons(announcement: announcement),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
        ],
      ),
    );
  }
}

class _DragHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.textMutedDark,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _AnnouncementHeader extends StatelessWidget {
  final AnnouncementModel announcement;

  const _AnnouncementHeader({required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _PriorityIcon(priority: announcement.priority),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                announcement.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              _AnnouncementTypeChip(type: announcement.type),
            ],
          ),
        ),
      ],
    );
  }
}

class _PriorityIcon extends StatelessWidget {
  final String priority;

  const _PriorityIcon({required this.priority});

  @override
  Widget build(BuildContext context) {
    Color color;
    dynamic icon;

    switch (priority.toLowerCase()) {
      case 'critical':
        color = AppColors.alertRed;
        icon = HugeIcons.strokeRoundedAlert01;
        break;
      case 'important':
        color = Colors.orange;
        icon = HugeIcons.strokeRoundedNotificationBlock01;
        break;
      default:
        color = AppColors.primaryBlue;
        icon = HugeIcons.strokeRoundedInformationCircle;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }
}

class _AnnouncementTypeChip extends StatelessWidget {
  final String type;

  const _AnnouncementTypeChip({required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.darkCanvas,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        type.replaceAll('_', ' ').toUpperCase(),
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: AppColors.textMutedDark,
        ),
      ),
    );
  }
}

class _AnnouncementContent extends StatelessWidget {
  final AnnouncementModel announcement;

  const _AnnouncementContent({required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCanvas,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        announcement.message,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white70,
          height: 1.5,
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final AnnouncementModel announcement;

  const _ActionButtons({required this.announcement});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnnouncementsController>();

    return Row(
      children: [
        if (announcement.ctaEnabled && announcement.ctaDeepLink != null) ...[
          Expanded(
            child: _CTAButton(
              text: announcement.ctaButtonText ?? 'Open',
              deepLink: announcement.ctaDeepLink!,
            ),
          ),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: _DismissButton(
            onPressed: () {
              controller.markAsRead(announcement.announcementId);
              Get.back();
            },
          ),
        ),
      ],
    );
  }
}

class _CTAButton extends StatelessWidget {
  final String text;
  final String deepLink;

  const _CTAButton({required this.text, required this.deepLink});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _handleDeepLink(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }

  Future<void> _handleDeepLink() async {
    try {
      // Handle internal app navigation
      if (deepLink.startsWith('/')) {
        Get.back(); // Close bottom sheet first
        Get.toNamed(deepLink);
        return;
      }

      // Handle external URLs
      if (deepLink.startsWith('http')) {
        final uri = Uri.parse(deepLink);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          Get.back(); // Close bottom sheet
        }
        return;
      }

      // Handle custom schemes (e.g., BillKit://feature)
      final uri = Uri.parse(deepLink);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
        Get.back(); // Close bottom sheet
      }
    } catch (e) {
      print('Error handling deep link: $e');
      Get.back(); // Close bottom sheet on error
    }
  }
}

class _DismissButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _DismissButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: BorderSide(color: Colors.grey[300]!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        'Dismiss',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}
