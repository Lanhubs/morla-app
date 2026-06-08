import 'package:get/get.dart';
import 'package:billkit/features/clients/controllers/new_client_controller.dart';
class NewClientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewClientController>(() => NewClientController());
  }
}