import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/features/announcements/controllers/announcements_controller.dart';
import 'package:billkit/features/announcements/widgets/announcement_card.dart';

class AnnouncementsView extends StatelessWidget {
  const AnnouncementsView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.darkCanvas,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AnnouncementsHeader(),
              const SizedBox(height: 8),
              _AnnouncementsSubtitle(),
              const SizedBox(height: 24),
              Expanded(child: _AnnouncementsList()),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnnouncementsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnnouncementsController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              const Text(
                'Notifications',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12),
              Obx(() {
                final unreadCount = controller.unreadCount.value;
                if (unreadCount == 0) return const SizedBox.shrink();

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.alertRed,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    unreadCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        _HeaderActions(),
      ],
    );
  }
}

class _HeaderActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnnouncementsController>();

    return Row(
      children: [
        Obx(() {
          final hasUnread = controller.unreadCount.value > 0;
          if (!hasUnread) return const SizedBox.shrink();

          return GestureDetector(
            onTap: () => controller.markAllAsRead(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: AppColors.primaryBlue.withValues(alpha: 0.3),
                ),
              ),
              child: const Text(
                'Mark all read',
                style: TextStyle(
                  color: AppColors.primaryBlue,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.darkSurface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.darkSurfaceStroke),
            ),
            child: const Icon(Icons.close, color: Colors.white, size: 16),
          ),
        ),
      ],
    );
  }
}

class _AnnouncementsSubtitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnnouncementsController>();

    return Obx(() {
      final totalCount = controller.announcements.length;
      final unreadCount = controller.unreadCount.value;

      String subtitle;
      if (totalCount == 0) {
        subtitle = 'No notifications yet';
      } else if (unreadCount == 0) {
        subtitle =
            'All caught up! $totalCount notification${totalCount == 1 ? '' : 's'} total';
      } else {
        subtitle =
            '$unreadCount unread of $totalCount notification${totalCount == 1 ? '' : 's'}';
      }

      return Text(
        subtitle,
        style: const TextStyle(color: AppColors.textMutedDark, fontSize: 12),
      );
    });
  }
}

class _AnnouncementsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnnouncementsController>();

    return Obx(() {
      if (controller.isLoading.value && controller.announcements.isEmpty) {
        return const _LoadingState();
      }

      if (controller.announcements.isEmpty) {
        return const _EmptyState();
      }

      return RefreshIndicator(
        onRefresh: () => controller.fetchAnnouncements(),
        backgroundColor: AppColors.darkSurface,
        color: AppColors.primaryBlue,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: controller.announcements.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final announcement = controller.announcements[index];
            return AnnouncementCard(announcement: announcement);
          },
        ),
      );
    });
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.primaryBlue),
          SizedBox(height: 16),
          Text(
            'Loading notifications...',
            style: TextStyle(color: AppColors.textMutedDark, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnnouncementsController>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.darkSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.darkSurfaceStroke),
            ),
            child: const HugeIcon(
              icon: HugeIcons.strokeRoundedNotificationOff01,
              color: AppColors.textMutedDark,
              size: 48,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No notifications yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'You\'ll see important updates and\ninformation from the team here',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textMutedDark,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 32),
          GestureDetector(
            onTap: () => controller.refreshAnnouncements(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.primaryBlue.withValues(alpha: 0.3),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedRefresh,
                    color: AppColors.primaryBlue,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Refresh',
                    style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
