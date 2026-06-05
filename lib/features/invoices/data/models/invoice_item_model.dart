class InvoiceItem {
  final String description;
  final int quantity;
  final double price;
  final double taxPercent;

  InvoiceItem({
    required this.description,
    required this.quantity,
    required this.price,
    required this.taxPercent,
  });

  double get total => quantity * price;

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    // Parse numeric safely whether it arrives as int, double or string from API/DB
    double parseDouble(dynamic val) {
      if (val == null) return 0.0;
      if (val is num) return val.toDouble();
      if (val is String) return double.tryParse(val) ?? 0.0;
      return 0.0;
    }

    return InvoiceItem(
      description: json['description'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      price: parseDouble(json['unitPrice'] ?? json['unit_price'] ?? json['price']),
      taxPercent: parseDouble(json['taxPercent'] ?? json['tax_percent']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'quantity': quantity,
      'unitPrice': price,
      'taxPercent': taxPercent,
    };
  }

  InvoiceItem copyWith({
    String? description,
    int? quantity,
    double? price,
    double? taxPercent,
  }) {
    return InvoiceItem(
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      taxPercent: taxPercent ?? this.taxPercent,
    );
  }
}
