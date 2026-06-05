import 'package:morla/features/invoices/data/models/invoice_item_model.dart';
import 'package:morla/features/settlement_methods/data/models/payout_method_model.dart';


class NewInvoiceModel {
  final String? id;
  final String clientId;
  final String clientName;
  final String clientEmail;
  final String clientPhone;
  final String clientAddress;
  final String clientCity;
  final String currency;
  final DateTime invoiceDate;
  final DateTime dueDate;
  final List<InvoiceItem> items;
  final double taxRate;
  final String paymentTerms;
  final String memo;
  final String? invoiceNumber;
  final String? status;
  final double subtotal;
  final double taxAmount;
  final double totalAmount;
  
  // Settlement fields
  final String? settlementMethod;
  final String? settlementAsset;

  // Payout method details (from getInvoice response)
  final PayoutMethodModel? payoutMethod;


  NewInvoiceModel({
    this.id,
    required this.clientId,
    required this.clientName,
    required this.clientEmail,
    required this.clientPhone,
    required this.clientAddress,
    required this.clientCity,
    required this.currency,
    required this.invoiceDate,
    required this.dueDate,
    required this.items,
    required this.taxRate,
    required this.paymentTerms,
    required this.memo,
    this.invoiceNumber,
    this.status,
    required this.subtotal,
    required this.taxAmount,
    required this.totalAmount,
    this.settlementMethod,
    this.settlementAsset,
    this.payoutMethod,
  });


  factory NewInvoiceModel.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic val) {
      if (val == null) return 0.0;
      if (val is num) return val.toDouble();
      if (val is String) return double.tryParse(val) ?? 0.0;
      return 0.0;
    }

    return NewInvoiceModel(
      id: json['id'] as String?,
      clientId: (json['client_id'] ?? json['clientId'] ?? '') as String,
      clientName: (json['client_name'] ?? json['clientName'] ?? '') as String,
      clientEmail: (json['client_email'] ?? json['clientEmail'] ?? '') as String,
      clientPhone: (json['client_phone'] ?? json['clientPhone'] ?? '') as String,
      clientAddress: (json['client_address'] ?? json['clientAddress'] ?? '') as String,
      clientCity: (json['client_city'] ?? json['clientCity'] ?? '') as String,
      currency: (json['currency'] ?? 'USD') as String,
      invoiceDate: DateTime.parse((json['invoice_date'] ?? json['invoiceDate'] ?? DateTime.now().toIso8601String()) as String),
      dueDate: DateTime.parse((json['due_date'] ?? json['dueDate'] ?? DateTime.now().toIso8601String()) as String),
      items: (json['items'] as List?)
              ?.map((e) => InvoiceItem.fromJson(e as Map<String, dynamic>))
              .toList() ?? [],
      taxRate: parseDouble(json['tax_rate'] ?? json['taxRate']),
      paymentTerms: (json['payment_terms'] ?? json['paymentTerms'] ?? '') as String,
      memo: (json['memo'] ?? '') as String,
      invoiceNumber: (json['invoice_number'] ?? json['invoiceNumber']) as String?,
      status: json['status'] as String?,
      subtotal: parseDouble(json['subtotal']),
      taxAmount: parseDouble(json['tax_amount'] ?? json['taxAmount']),
      totalAmount: parseDouble(json['total_amount'] ?? json['totalAmount']),
      settlementMethod: (json['payment_method_type'] ?? json['paymentMethodType']) as String?,
      settlementAsset: (json['payment_method_label'] ?? json['paymentMethodLabel']) as String?,
      payoutMethod: json['payoutMethod'] != null
          ? PayoutMethodModel.fromJson(json['payoutMethod'] as Map<String, dynamic>)
          : null,
    );

  }

  Map<String, dynamic> toJson() {
    return {
      'clientId': clientId,
      'clientName': clientName,
      'clientEmail': clientEmail,
      'clientPhone': clientPhone,
      'clientAddress': clientAddress,
      'clientCity': clientCity,
      'currency': currency,
      'invoiceDate': invoiceDate.toIso8601String().split('T').first,
      'dueDate': dueDate.toIso8601String().split('T').first,
      'items': items.map((e) => e.toJson()).toList(),
      'taxRate': taxRate,
      'paymentTerms': paymentTerms,
      'memo': memo,
      if (settlementMethod != null) 'paymentMethodType': settlementMethod,
      if (settlementAsset != null) 'paymentMethodLabel': settlementAsset,
    };
  }

  factory NewInvoiceModel.empty() {
    return NewInvoiceModel(
      id: null,
      clientId: '',
      clientName: '',
      clientEmail: '',
      clientPhone: '',
      clientAddress: '',
      clientCity: '',
      currency: 'USD',
      invoiceDate: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 30)),
      items: [],
      taxRate: 5,
      paymentTerms: 'Net 30',
      memo: '',
      subtotal: 0,
      taxAmount: 0,
      totalAmount: 0,
      settlementMethod: null,
      settlementAsset: null,
      payoutMethod: null,

    );
  }
}
