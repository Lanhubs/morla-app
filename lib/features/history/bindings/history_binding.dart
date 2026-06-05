import "package:get/get.dart";
import "package:morla/features/history/controllers/history_controller.dart";

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HistoryController());
  }
}
