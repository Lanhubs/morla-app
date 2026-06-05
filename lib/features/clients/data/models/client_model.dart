class Client {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String company;
  final String jobTitle;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final String taxId;
  final String paymentTerms;
  final String notes;
  final String status; // "Settled" or "Awaiting"
  final double revenue;
  final String avatarUrl;
  final DateTime createdAt;

  Client({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.company,
    required this.jobTitle,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.taxId,
    required this.paymentTerms,
    required this.notes,
    required this.status,
    required this.revenue,
    required this.avatarUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'company': company,
      'jobTitle': jobTitle,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'country': country,
      'taxId': taxId,
      'paymentTerms': paymentTerms,
      'notes': notes,
      'status': status,
      'revenue': revenue,
      'avatarUrl': avatarUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      company: json['company'] ?? '',
      jobTitle: json['jobTitle'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      zipCode: json['zipCode'] ?? '',
      country: json['country'] ?? '',
      taxId: json['taxId'] ?? '',
      paymentTerms: json['paymentTerms'] ?? '',
      notes: json['notes'] ?? '',
      status: json['status'] ?? 'Awaiting',
      revenue: (json['revenue'] != null)
          ? double.tryParse(json['revenue'].toString()) ?? 0.0
          : 0.0,
      avatarUrl: json['avatarUrl'] ?? json['avatar_url'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
