import 'auth_user_model.dart';

class AuthSessionModel {
  final String accessToken;
  final String expiresAt;
  final AuthUserModel user;

  const AuthSessionModel({
    required this.accessToken,
    required this.expiresAt,
    required this.user,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'] as Map<String, dynamic>? ?? {};

    return AuthSessionModel(
      accessToken: json['accessToken'] as String? ?? '',
      expiresAt: json['expiresAt'] as String? ?? '',
      user: AuthUserModel.fromJson(userJson),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'expiresAt': expiresAt,
      'user': user.toJson(),
    };
  }
}
