import 'package:get/get.dart';
import 'package:billkit/core/services/auth_token_storage_service.dart';
import 'package:billkit/features/sign-up/data/models/auth_user_model.dart';
import 'package:billkit/features/sign-up/data/repositories/sign_up_repository.dart';

class CurrentUserController extends GetxController {
  final SignUpRepository _repository;
  final AuthTokenStorageService _tokenStorage;

  CurrentUserController({
    required SignUpRepository repository,
    required AuthTokenStorageService tokenStorage,
  }) : _repository = repository,
       _tokenStorage = tokenStorage;

  final user = Rxn<AuthUserModel>();
  final isLoading = false.obs;
  final isAuthenticated = false.obs;

  Future<void> loadCurrentUser({bool force = false}) async {
    if (isLoading.value) {
      return;
    }

    if (!force && user.value != null && isAuthenticated.value) {
      return;
    }

    final token = await _tokenStorage.getToken();
    if (token == null || token.isEmpty) {
      user.value = null;
      isAuthenticated.value = false;
      return;
    }

    isLoading.value = true;

    try {
      final response = await _repository.me();
      user.value = AuthUserModel.fromJson(response);
      isAuthenticated.value = true;
    } catch (_) {
      await clearSession();
    } finally {
      isLoading.value = false;
    }
  }

  void setCurrentUser(AuthUserModel value) {
    user.value = value;
    isAuthenticated.value = true;
  }

  Future<void> clearSession() async {
    await _tokenStorage.clearToken();
    user.value = null;
    isAuthenticated.value = false;
  }
}
