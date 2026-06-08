import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/core/utils/snack_helper.dart';
import 'package:billkit/features/invoice_details/controllers/invoice_details_controller.dart';
import 'package:billkit/features/settlement_methods/data/models/payout_method_model.dart';
import 'qr_pattern_painter.dart';

class SettlementDetailsSection extends StatelessWidget {
  const SettlementDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InvoiceDetailsController>();
    return Obx(() {
      final invoice = controller.invoice.value;
      if (invoice == null) return const SizedBox.shrink();

      final method = invoice.payoutMethod;
      final isCrypto = invoice.settlementMethod == 'crypto';

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.darkSurfaceStroke, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(isCrypto: isCrypto),
            const SizedBox(height: 16),
            if (method != null)
              isCrypto
                  ? CryptoDetails(method: method)
                  : BankDetails(method: method)
            else
              FallbackSettlement(
                methodType: invoice.settlementMethod,
                asset: invoice.settlementAsset,
              ),
          ],
        ),
      );
    });
  }
}

class SectionHeader extends StatelessWidget {
  final bool isCrypto;

  const SectionHeader({super.key, required this.isCrypto});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isCrypto
                ? const Color(0xFF8B5CF6).withValues(alpha: 0.15)
                : AppColors.primaryBlue.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            isCrypto ? Icons.currency_bitcoin : Icons.account_balance,
            color: isCrypto ? const Color(0xFF8B5CF6) : AppColors.primaryBlue,
            size: 16,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          isCrypto ? 'Crypto Settlement' : 'Bank Settlement',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class CryptoDetails extends StatelessWidget {
  final PayoutMethodModel method;

  const CryptoDetails({super.key, required this.method});

  @override
  Widget build(BuildContext context) {
    final address = method.walletAddress ?? '';
    final network = method.walletNetwork ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Network badge
        DetailRow(label: 'Network', value: network.toUpperCase()),
        const SizedBox(height: 12),
        DetailRow(label: 'Asset', value: method.label),
        const SizedBox(height: 16),

        // Wallet address with QR
        const Text(
          'WALLET ADDRESS',
          style: TextStyle(
            color: AppColors.textMutedDark,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              // QR code placeholder using a grid pattern
              QrPlaceholder(data: address),
              const SizedBox(height: 12),
              Text(
                address,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Copy button
        GestureDetector(
          onTap: () {
            Clipboard.setData(ClipboardData(text: address));
            SnackHelper.showInfo(
              "Wallet address copied to clipboard",
              title: "Copied",
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.primaryBlue.withValues(alpha: 0.3),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.copy, color: AppColors.primaryBlue, size: 14),
                SizedBox(width: 6),
                Text(
                  'Copy Address',
                  style: TextStyle(
                    color: AppColors.primaryBlue,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class QrPlaceholder extends StatelessWidget {
  final String data;

  const QrPlaceholder({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // Generate a deterministic grid pattern from the address string
    final hash = data.hashCode;
    return SizedBox(
      width: 140,
      height: 140,
      child: CustomPaint(painter: QrPatternPainter(hash)),
    );
  }
}

class BankDetails extends StatelessWidget {
  final PayoutMethodModel method;

  const BankDetails({super.key, required this.method});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailRow(label: 'Bank Name', value: method.bankName ?? '-'),
        const SizedBox(height: 10),
        DetailRow(label: 'Account Name', value: method.accountName ?? '-'),
        const SizedBox(height: 10),
        DetailRow(label: 'Account Number', value: method.accountNumber ?? '-'),
        const SizedBox(height: 10),
        if (method.bankSwift != null && method.bankSwift!.isNotEmpty) ...[
          DetailRow(label: 'SWIFT Code', value: method.bankSwift!),
          const SizedBox(height: 10),
        ],
        DetailRow(label: 'Label', value: method.label),
      ],
    );
  }
}

class FallbackSettlement extends StatelessWidget {
  final String? methodType;
  final String? asset;

  const FallbackSettlement({super.key, this.methodType, this.asset});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailRow(
          label: 'Method',
          value: methodType?.toUpperCase() ?? 'NOT SET',
        ),
        if (asset != null && asset!.isNotEmpty) ...[
          const SizedBox(height: 10),
          DetailRow(label: 'Asset', value: asset!),
        ],
        const SizedBox(height: 12),
        const Text(
          'No payout account linked to this invoice yet.',
          style: TextStyle(
            color: AppColors.textMutedDark,
            fontSize: 11,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.textMutedDark, fontSize: 12),
        ),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
