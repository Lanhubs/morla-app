import 'package:get/get.dart';
import 'package:billkit/features/payment-setup/controllers/payment_setup_controller.dart';

import 'package:billkit/features/settlement_methods/data/repositories/payout_methods_repository.dart';

class PaymentSetupBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PayoutMethodsRepository>(() => PayoutMethodsRepository());
    Get.lazyPut(() => PaymentSetupController());
  }
}
