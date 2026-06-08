import 'package:get/get.dart';
import 'package:billkit/core/controllers/current_user_controller.dart';
import 'package:billkit/core/services/auth_dependency.dart';
import 'package:billkit/features/dashboard/controllers/home_controller.dart';
import 'package:billkit/features/clients/controllers/clients_controller.dart';
import 'package:billkit/features/history/controllers/history_controller.dart';
import 'package:billkit/features/invoices/controllers/invoices_controller.dart';

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
