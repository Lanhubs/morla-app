import 'package:dio/dio.dart';
import 'package:billkit/core/services/app_api_client.dart';
import 'package:get/get.dart' as getx;

class OAuthRepository {
  final AppApiClient _apiClient = getx.Get.find<AppApiClient>();

  Future<GoogleAuthResponse> authenticateWithGoogle({
    required String idToken,
    Map<String, dynamic>? deviceInfo,
  }) async {
    try {
      final response = await _apiClient.post(
        '/oauth/google',
        data: {'idToken': idToken, 'deviceInfo': deviceInfo},
      );

      return GoogleAuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Google authentication failed',
      );
    } catch (e) {
      throw Exception('An unexpected error occurred');
    }
  }
}

class GoogleAuthResponse {
  final String accessToken;
  final String expiresAt;
  final bool isNewUser;
  final User user;

  GoogleAuthResponse({
    required this.accessToken,
    required this.expiresAt,
    required this.isNewUser,
    required this.user,
  });

  factory GoogleAuthResponse.fromJson(Map<String, dynamic> json) {
    return GoogleAuthResponse(
      accessToken: json['accessToken'] as String,
      expiresAt: json['expiresAt'] as String,
      isNewUser: json['isNewUser'] as bool,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class User {
  final String id;
  final String email;
  final String? fullName;
  final String? phone;
  final String? planTier;
  final String? emailVerifiedAt;
  final String? businessName;
  final String? websiteUrl;
  final String? signatureUrl;
  final String? avatarUrl;
  final String? googleId;

  User({
    required this.id,
    required this.email,
    this.fullName,
    this.phone,
    this.planTier,
    this.emailVerifiedAt,
    this.businessName,
    this.websiteUrl,
    this.signatureUrl,
    this.avatarUrl,
    this.googleId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String?,
      phone: json['phone'] as String?,
      planTier: json['planTier'] as String?,
      emailVerifiedAt: json['emailVerifiedAt'] as String?,
      businessName: json['businessName'] as String?,
      websiteUrl: json['websiteUrl'] as String?,
      signatureUrl: json['signatureUrl'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      googleId: json['googleId'] as String?,
    );
  }
}
