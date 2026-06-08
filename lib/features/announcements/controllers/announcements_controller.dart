import 'package:get/get.dart';
import 'package:billkit/core/services/socket_service.dart';
import 'package:billkit/core/services/app_api_client.dart';
import 'package:billkit/features/announcements/data/models/announcement_model.dart';
import 'package:billkit/features/announcements/widgets/announcement_bottom_sheet.dart';

class AnnouncementsController extends GetxController {
  final SocketService _socketService = Get.find<SocketService>();
  final AppApiClient _apiClient = Get.find<AppApiClient>();

  final RxList<AnnouncementModel> announcements = <AnnouncementModel>[].obs;
  final RxInt unreadCount = 0.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _setupAnnouncementListener();
    fetchAnnouncements();
    fetchUnreadCount();
  }

  void _setupAnnouncementListener() {
    _socketService.onAnnouncementReceived((data) {
      final announcement = AnnouncementModel.fromJson(data);

      // Add to list at the beginning
      announcements.insert(0, announcement);
      unreadCount.value++;

      // Show bottom sheet notification
      _showAnnouncementBottomSheet(announcement);
    });
  }

  void _showAnnouncementBottomSheet(AnnouncementModel announcement) {
    Get.bottomSheet(
      AnnouncementBottomSheet(announcement: announcement),
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
    );
  }

  Future<void> fetchAnnouncements() async {
    try {
      isLoading.value = true;

      final response = await _apiClient.get('/user/announcements');

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> data = response.data as List<dynamic>;
        announcements.value = data
            .map(
              (json) =>
                  AnnouncementModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      }
    } catch (e) {
      print('Error fetching announcements: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUnreadCount() async {
    try {
      final response = await _apiClient.get('/user/announcements/unread-count');

      if (response.statusCode == 200 && response.data != null) {
        unreadCount.value = response.data['count'] ?? 0;
      }
    } catch (e) {
      print('Error fetching unread count: $e');
    }
  }

  Future<void> markAsRead(String announcementId) async {
    try {
      final response = await _apiClient.put(
        '/user/announcements/$announcementId/read',
      );

      if (response.statusCode == 200) {
        // Update local state
        final index = announcements.indexWhere(
          (a) => a.announcementId == announcementId,
        );
        if (index != -1 && !announcements[index].read) {
          announcements[index] = announcements[index].copyWith(
            read: true,
            readAt: DateTime.now(),
          );
          announcements.refresh();

          if (unreadCount.value > 0) {
            unreadCount.value--;
          }
        }
      }
    } catch (e) {
      print('Error marking announcement as read: $e');
    }
  }

  Future<void> markAllAsRead() async {
    try {
      final response = await _apiClient.put('/user/announcements/read-all');

      if (response.statusCode == 200) {
        // Update all local announcements
        for (int i = 0; i < announcements.length; i++) {
          if (!announcements[i].read) {
            announcements[i] = announcements[i].copyWith(
              read: true,
              readAt: DateTime.now(),
            );
          }
        }
        announcements.refresh();
        unreadCount.value = 0;
      }
    } catch (e) {
      print('Error marking all as read: $e');
    }
  }

  Future<void> deleteAnnouncement(String announcementId) async {
    try {
      final response = await _apiClient.delete(
        '/user/announcements/$announcementId',
      );

      if (response.statusCode == 200) {
        final index = announcements.indexWhere(
          (a) => a.announcementId == announcementId,
        );
        if (index != -1) {
          if (!announcements[index].read && unreadCount.value > 0) {
            unreadCount.value--;
          }
          announcements.removeAt(index);
        }
      }
    } catch (e) {
      print('Error deleting announcement: $e');
    }
  }

  void refreshAnnouncements() {
    fetchAnnouncements();
    fetchUnreadCount();
  }
}
