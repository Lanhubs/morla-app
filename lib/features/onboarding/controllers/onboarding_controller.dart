import "package:get/get.dart";
class OnboardingController extends GetxController {
  final RxInt currentPage = 0.obs;

  void changePage(int index) {
    currentPage.value = index;
    update();
  }
}