import 'package:dio/dio.dart';
import 'package:billkit/core/services/app_api_client.dart';
import 'package:billkit/features/sign-up/data/models/auth_session_model.dart';

class SignUpRepository {
  final AppApiClient _apiClient;

  const SignUpRepository({required AppApiClient apiClient})
    : _apiClient = apiClient;

  Future<void> requestOtp({required String email}) async {
    try {
      await _apiClient.dio.post('/auth/request-otp', data: {'email': email});
    } on DioException catch (error) {
      throw Exception(_extractErrorMessage(error));
    }
  }

  Future<AuthSessionModel> verifyOtp({
    required String email,
    required String code,
    String? fullName,
    String? phone,
  }) async {
    try {
      final payload = <String, dynamic>{'email': email, 'code': code};

      if (fullName != null && fullName.trim().isNotEmpty) {
        payload['fullName'] = fullName.trim();
      }

      if (phone != null && phone.trim().isNotEmpty) {
        payload['phone'] = phone.trim();
      }

      final response = await _apiClient.dio.post(
        '/auth/verify-otp',
        data: payload,
      );

      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw Exception('Invalid server response');
      }

      return AuthSessionModel.fromJson(data);
    } on DioException catch (error) {
      throw Exception(_extractErrorMessage(error));
    }
  }

  Future<Map<String, dynamic>> me() async {
    try {
      final response = await _apiClient.dio.get('/auth/me');

      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw Exception('Invalid server response');
      }

      return data;
    } on DioException catch (error) {
      throw Exception(_extractErrorMessage(error));
    }
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.dio.patch('/auth/me', data: data);

      final responseData = response.data;
      if (responseData is! Map<String, dynamic>) {
        throw Exception('Invalid server response');
      }

      return responseData;
    } on DioException catch (error) {
      throw Exception(_extractErrorMessage(error));
    }
  }

  String _extractErrorMessage(DioException error) {
    final data = error.response?.data;

    if (data is Map<String, dynamic>) {
      final message = data['message'];
      if (message is String && message.isNotEmpty) {
        return message;
      }
    }

    return error.message ?? 'Request failed';
  }
}
