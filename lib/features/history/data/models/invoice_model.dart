class Invoice {
  final String id;
  final String invoiceNumber;
  final String clientName;
  final String clientId;
  final double amount;
  final String status; // 'SENT', 'PAID', 'OVERDUE', 'DRAFT'
  final DateTime date;
  final DateTime? dueDate;
  final String description;

  Invoice({
    required this.id,
    required this.invoiceNumber,
    required this.clientName,
    required this.clientId,
    required this.amount,
    required this.status,
    required this.date,
    this.dueDate,
    this.description = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoiceNumber': invoiceNumber,
      'clientName': clientName,
      'clientId': clientId,
      'amount': amount,
      'status': status,
      'date': date.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'description': description,
    };
  }

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'] ?? '',
      invoiceNumber: json['invoiceNumber'] ?? '',
      clientName: json['clientName'] ?? '',
      clientId: json['clientId'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? 'DRAFT',
      date: json['date'] != null
          ? DateTime.tryParse(json['date'] as String) ?? DateTime.now()
          : DateTime.now(),
      dueDate: json['dueDate'] != null
          ? DateTime.tryParse(json['dueDate'] as String)
          : null,
      description: json['description'] ?? '',
    );
  }

  Invoice copyWith({
    String? id,
    String? invoiceNumber,
    String? clientName,
    String? clientId,
    double? amount,
    String? status,
    DateTime? date,
    DateTime? dueDate,
    String? description,
  }) {
    return Invoice(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      clientName: clientName ?? this.clientName,
      clientId: clientId ?? this.clientId,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      date: date ?? this.date,
      dueDate: dueDate ?? this.dueDate,
      description: description ?? this.description,
    );
  }
}
