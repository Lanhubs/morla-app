import 'package:get/get.dart';
import 'package:morla/core/services/auth_dependency.dart';
import 'package:morla/features/new_invoice/controllers/new_invoice_controller.dart';

import 'package:morla/features/settlement_methods/data/repositories/payout_methods_repository.dart';

class NewInvoiceBinding extends Bindings {
  @override
  void dependencies() {
    AuthDependency.ensureRegistered();
    Get.lazyPut<PayoutMethodsRepository>(() => PayoutMethodsRepository());
    Get.lazyPut<NewInvoiceController>(() => NewInvoiceController());
  }
}
