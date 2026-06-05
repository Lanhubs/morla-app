import 'package:get/get.dart';
import 'package:morla/core/services/app_api_client.dart';
import 'package:morla/features/dashboard/controllers/dashboard_controller.dart';
import 'package:morla/features/dashboard/data/repositories/dashboard_repository.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(
        repository: DashboardRepository(apiClient: Get.find<AppApiClient>()),
      ),
    );
  }
}
