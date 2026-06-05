class PayoutMethodModel {
  final String id;
  final String methodType;
  final String label;
  final bool isDefault;
  final String? accountName;
  final String? accountNumber;
  final String? bankName;
  final String? bankSwift;
  final String? walletNetwork;
  final String? walletAddress;
  final DateTime createdAt;

  PayoutMethodModel({
    required this.id,
    required this.methodType,
    required this.label,
    required this.isDefault,
    this.accountName,
    this.accountNumber,
    this.bankName,
    this.bankSwift,
    this.walletNetwork,
    this.walletAddress,
    required this.createdAt,
  });

  factory PayoutMethodModel.fromJson(Map<String, dynamic> json) {
    return PayoutMethodModel(
      id: json['id'] as String,
      methodType: json['method_type'] as String,
      label: json['label'] as String,
      isDefault: json['is_default'] as bool? ?? false,
      accountName: json['account_name'] as String?,
      accountNumber: json['account_number'] as String?,
      bankName: json['bank_name'] as String?,
      bankSwift: json['bank_swift'] as String?,
      walletNetwork: json['wallet_network'] as String?,
      walletAddress: json['wallet_address'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'methodType': methodType,
      'label': label,
      'isDefault': isDefault,
    };

    if (methodType == 'bank') {
      data['accountName'] = accountName;
      data['accountNumber'] = accountNumber;
      data['bankName'] = bankName;
      data['bankSwift'] = bankSwift ?? '';
    } else if (methodType == 'crypto') {
      data['walletNetwork'] = walletNetwork;
      data['walletAddress'] = walletAddress;
    }

    return data;
  }
}
