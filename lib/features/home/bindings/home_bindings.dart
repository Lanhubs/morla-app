import 'package:get/get.dart';
import 'package:morla/core/controllers/current_user_controller.dart';
import 'package:morla/core/services/auth_dependency.dart';
import 'package:morla/features/dashboard/controllers/home_controller.dart';
import 'package:morla/features/clients/controllers/clients_controller.dart';
import 'package:morla/features/history/controllers/history_controller.dart';
import 'package:morla/features/invoices/controllers/invoices_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    AuthDependency.ensureRegistered();

    Get.put(HomeController());
    Get.lazyPut<ClientsController>(() => ClientsController());
    Get.lazyPut<HistoryController>(() => HistoryController());
    Get.lazyPut<InvoicesController>(() => InvoicesController());

    Get.find<CurrentUserController>().loadCurrentUser();
  }
}
