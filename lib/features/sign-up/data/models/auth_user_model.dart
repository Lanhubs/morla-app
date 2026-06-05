class AuthUserModel {
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

  const AuthUserModel({
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
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      fullName: json['fullName'] as String?,
      phone: json['phone'] as String?,
      planTier: json['planTier'] as String?,
      emailVerifiedAt: json['emailVerifiedAt'] as String?,
      businessName: json['businessName'] as String?,
      websiteUrl: json['websiteUrl'] as String?,
      signatureUrl: json['signatureUrl'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
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
      'businessName': businessName,
      'websiteUrl': websiteUrl,
      'signatureUrl': signatureUrl,
      'avatarUrl': avatarUrl,
    };
  }
}
