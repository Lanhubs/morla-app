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
      invoiceNumber: json['invoiceNumber'] ?? json['invoice_number'] ?? '',
      clientName: json['clientName'] ?? json['client_name'] ?? '',
      clientId: json['clientId'] ?? json['client_id'] ?? '',
      amount: double.tryParse((json['amount'] ?? json['total_amount'] ?? '0').toString()) ?? 0.0,
      status: json['status'] ?? 'DRAFT',
      date: (json['date'] ?? json['invoice_date']) != null
          ? DateTime.tryParse((json['date'] ?? json['invoice_date']) as String) ?? DateTime.now()
          : DateTime.now(),
      dueDate: (json['dueDate'] ?? json['due_date']) != null
          ? DateTime.tryParse((json['dueDate'] ?? json['due_date']) as String)
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
