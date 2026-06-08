import 'package:get/get.dart';
import 'package:billkit/features/invoice_details/controllers/invoice_details_controller.dart';

class InvoiceDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoiceDetailsController>(() => InvoiceDetailsController());
  }
}