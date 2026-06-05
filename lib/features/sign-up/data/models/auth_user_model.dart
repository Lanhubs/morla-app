class AuthUserModel {
  final String id;
  final String email;
  final String? fullName;
  final String? phone;
  final String? planTier;
  final String? emailVerifiedAt;

  const AuthUserModel({
    required this.id,
    required this.email,
    this.fullName,
    this.phone,
    this.planTier,
    this.emailVerifiedAt,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      fullName: json['fullName'] as String?,
      phone: json['phone'] as String?,
      planTier: json['planTier'] as String?,
      emailVerifiedAt: json['emailVerifiedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'phone': phone,
      'planTier': planTier,
      'emailVerifiedAt': emailVerifiedAt,
    };
  }
}
