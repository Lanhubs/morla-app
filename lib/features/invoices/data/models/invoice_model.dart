import 'package:billkit/features/invoices/data/models/invoice_item_model.dart';

class InvoiceModel {
  final String id;
  final String clientName;
  final String clientAddress;
  final String clientCity;
  final String clientEmail;
  final String clientPhone;
  final DateTime date;
  final DateTime dueDate;
  final List<InvoiceItem> items;
  final double taxRate;
  final String settlement;
  final String transactionHash;
  final bool isOverdue;
  final bool emailPingsEnabled;

  InvoiceModel({
    required this.id,
    required this.clientName,
    required this.clientAddress,
    required this.clientCity,
    required this.clientEmail,
    required this.clientPhone,
    required this.date,
    required this.dueDate,
    required this.items,
    required this.taxRate,
    required this.settlement,
    required this.transactionHash,
    this.isOverdue = false,
    this.emailPingsEnabled = true,
  });

  double get subtotal => items.fold(0, (sum, i) => sum + i.total);
  double get calculatedTax => subtotal * (taxRate / 100);
  double get grandTotal => subtotal + calculatedTax;

  String get formattedDate {
    return '${_monthName(date.month)} ${date.day.toString().padLeft(2, '0')}, ${date.year}';
  }

  String get formattedDueDate {
    return '${_monthName(dueDate.month)} ${dueDate.day.toString().padLeft(2, '0')}, ${dueDate.year}';
  }

  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return months[month - 1];
  }

  /// Mock list of invoices for the history view
  static List<InvoiceModel> get mockInvoices => [
    InvoiceModel(
      id: '#INV-883901',
      clientName: 'Aetheric Corp.',
      clientAddress: '123 Tech Park, Suite 5A',
      clientCity: 'San Francisco, CA 94107',
      clientEmail: 'billing@aethericcorp.com',
      clientPhone: '+1 (415) 555-0110',
      date: DateTime(2023, 10, 24),
      dueDate: DateTime(2023, 11, 7),
      taxRate: 8.5,
      settlement: 'USDC (Polygon)',
      transactionHash: '0x71C7658EC7ab88b098defB751B7401B5f6d...',
      isOverdue: true,
      items: [
        InvoiceItem(description: 'Cloud Render Nodes', quantity: 480, price: 0.25, taxPercent: 8.5),
        InvoiceItem(description: 'Edge API Latency Opt.', quantity: 1, price: 450.0, taxPercent: 8.5),
        InvoiceItem(description: 'Platform Tax', quantity: 1, price: 48.45, taxPercent: 0),
      ],
    ),
    InvoiceModel(
      id: '#INV-774400',
      clientName: 'Nexus Digital',
      clientAddress: '88 Westfield Avenue',
      clientCity: 'Austin, TX 78701',
      clientEmail: 'accounts@nexusdigital.io',
      clientPhone: '+1 (512) 555-0247',
      date: DateTime(2023, 9, 10),
      dueDate: DateTime(2023, 10, 10),
      taxRate: 10.0,
      settlement: 'ETH (Mainnet)',
      transactionHash: '0xA19B23FD4e1C8b77dca2E01fB9920AC3E01d82...',
      isOverdue: false,
      items: [
        InvoiceItem(description: 'Frontend Development', quantity: 40, price: 85.0, taxPercent: 10),
        InvoiceItem(description: 'Backend API Integration', quantity: 20, price: 110.0, taxPercent: 10),
      ],
    ),
    InvoiceModel(
      id: '#INV-662233',
      clientName: 'Forge Energy Ltd.',
      clientAddress: '456 Industrial Pkwy',
      clientCity: 'New York, NY 10001',
      clientEmail: 'hello@forgeenergy.com',
      clientPhone: '+1 (800) 987-6543',
      date: DateTime(2023, 8, 1),
      dueDate: DateTime(2023, 8, 15),
      taxRate: 10.0,
      settlement: 'USDC (Polygon)',
      transactionHash: '0xC3E82FA9Bb6d91a0EfC82847a01B7A93F12f11...',
      isOverdue: false,
      items: [
        InvoiceItem(description: 'Solar Panel Installation', quantity: 1, price: 3000.0, taxPercent: 10),
        InvoiceItem(description: 'Inverter & Battery Setup', quantity: 1, price: 1500.0, taxPercent: 10),
      ],
    ),
  ];
}
