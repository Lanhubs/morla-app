import 'package:get/get.dart';
import 'package:billkit/core/services/auth_dependency.dart';
import 'package:billkit/features/new_invoice/controllers/new_invoice_controller.dart';

import 'package:billkit/features/settlement_methods/data/repositories/payout_methods_repository.dart';

class NewInvoiceBinding extends Bindings {
  @override
  void dependencies() {
    AuthDependency.ensureRegistered();
    Get.lazyPut<PayoutMethodsRepository>(() => PayoutMethodsRepository());
    Get.lazyPut<NewInvoiceController>(() => NewInvoiceController());
  }
}
