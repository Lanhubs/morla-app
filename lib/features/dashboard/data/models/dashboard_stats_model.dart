class DashboardStatsModel {
  final int totalInvoices;
  final double totalPaid;
  final double totalUnpaid;

  const DashboardStatsModel({
    required this.totalInvoices,
    required this.totalPaid,
    required this.totalUnpaid,
  });

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      totalInvoices: json['totalInvoices'] as int? ?? 0,
      totalPaid: (json['totalPaid'] as num?)?.toDouble() ?? 0.0,
      totalUnpaid: (json['totalUnpaid'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalInvoices': totalInvoices,
      'totalPaid': totalPaid,
      'totalUnpaid': totalUnpaid,
    };
  }
}
