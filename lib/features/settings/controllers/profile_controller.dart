import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/controllers/current_user_controller.dart';
import 'package:billkit/features/sign-up/data/models/auth_user_model.dart';
import 'package:billkit/features/sign-up/data/repositories/sign_up_repository.dart';

class ProfileController extends GetxController {
  final CurrentUserController _currentUserController = Get.find<CurrentUserController>();
  final SignUpRepository _repository = Get.find<SignUpRepository>();

  final businessNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final websiteUrlController = TextEditingController();
  
  final isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initFields();
  }

  void _initFields() {
    final user = _currentUserController.user.value;
    if (user != null) {
      businessNameController.text = user.businessName ?? '';
      emailController.text = user.email;
      phoneController.text = user.phone ?? '';
      websiteUrlController.text = user.websiteUrl ?? '';
    }
  }

  AuthUserModel? get user => _currentUserController.user.value;

  Future<void> saveProfile() async {
    isSaving.value = true;
    try {
      final data = {
        'businessName': businessNameController.text.trim(),
        'phone': phoneController.text.trim(),
        'websiteUrl': websiteUrlController.text.trim(),
      };

      final response = await _repository.updateProfile(data);
      _currentUserController.setCurrentUser(AuthUserModel.fromJson(response));
      Get.snackbar('Success', 'Profile updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    businessNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    websiteUrlController.dispose();
    super.onClose();
  }
}
