import 'package:billkit/features/history/data/models/invoice_model.dart';

class DashboardStatsModel {
  final int totalInvoices;
  final double totalPaid;
  final double totalUnpaid;
  final List<Invoice> invoices;

  const DashboardStatsModel({
    required this.totalInvoices,
    required this.totalPaid,
    required this.totalUnpaid,
    required this.invoices
  });

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      totalInvoices: json['totalInvoices'] as int? ?? 0,
      totalPaid: double.tryParse(json['totalPaid']?.toString() ?? '0') ?? 0.0,
      totalUnpaid: double.tryParse(json['totalUnpaid']?.toString() ?? '0') ?? 0.0,
      invoices: (json['invoices'] as List<dynamic>?)?.map((e) => Invoice.fromJson(e as Map<String, dynamic>)).toList() ?? [],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalInvoices': totalInvoices,
      'totalPaid': totalPaid,
      'totalUnpaid': totalUnpaid,
      'invoices': invoices,
    };
  }
}
