import 'package:get/get.dart';
import 'package:morla/features/clients/controllers/new_client_controller.dart';
class NewClientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewClientController>(() => NewClientController());
  }
}