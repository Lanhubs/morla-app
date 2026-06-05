import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:morla/core/theme/app_colors.dart';
import 'package:morla/core/utils/snack_helper.dart';
import 'package:morla/features/invoice_details/controllers/invoice_details_controller.dart';
import 'package:morla/features/settlement_methods/data/models/payout_method_model.dart';

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
            _buildSectionHeader(isCrypto),
            const SizedBox(height: 16),
            if (method != null)
              isCrypto ? _buildCryptoDetails(method) : _buildBankDetails(method)
            else
              _buildFallbackSettlement(
                invoice.settlementMethod,
                invoice.settlementAsset,
              ),
          ],
        ),
      );
    });
  }

  Widget _buildSectionHeader(bool isCrypto) {
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

  Widget _buildCryptoDetails(PayoutMethodModel method) {
    final address = method.walletAddress ?? '';
    final network = method.walletNetwork ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Network badge
        _buildDetailRow('Network', network.toUpperCase()),
        const SizedBox(height: 12),
        _buildDetailRow('Asset', method.label),
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
              _buildQrPlaceholder(address),
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

  Widget _buildQrPlaceholder(String data) {
    // Generate a deterministic grid pattern from the address string
    final hash = data.hashCode;
    return SizedBox(
      width: 140,
      height: 140,
      child: CustomPaint(painter: _QrPatternPainter(hash)),
    );
  }

  Widget _buildBankDetails(PayoutMethodModel method) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Bank Name', method.bankName ?? '-'),
        const SizedBox(height: 10),
        _buildDetailRow('Account Name', method.accountName ?? '-'),
        const SizedBox(height: 10),
        _buildDetailRow('Account Number', method.accountNumber ?? '-'),
        const SizedBox(height: 10),
        if (method.bankSwift != null && method.bankSwift!.isNotEmpty) ...[
          _buildDetailRow('SWIFT Code', method.bankSwift!),
          const SizedBox(height: 10),
        ],
        _buildDetailRow('Label', method.label),
      ],
    );
  }

  Widget _buildFallbackSettlement(String? methodType, String? asset) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Method', methodType?.toUpperCase() ?? 'NOT SET'),
        if (asset != null && asset.isNotEmpty) ...[
          const SizedBox(height: 10),
          _buildDetailRow('Asset', asset),
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

  Widget _buildDetailRow(String label, String value) {
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

class _QrPatternPainter extends CustomPainter {
  final int seed;
  _QrPatternPainter(this.seed);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;
    const gridSize = 21;
    final cellSize = size.width / gridSize;

    // Draw border
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        // Corner finder patterns (7x7 squares in 3 corners)
        if (_isFinderPattern(i, j, gridSize)) {
          canvas.drawRect(
            Rect.fromLTWH(j * cellSize, i * cellSize, cellSize, cellSize),
            paint,
          );
          continue;
        }

        // Pseudo-random data modules
        final val = (seed + i * 37 + j * 13) % 3;
        if (val == 0) {
          canvas.drawRect(
            Rect.fromLTWH(j * cellSize, i * cellSize, cellSize, cellSize),
            paint,
          );
        }
      }
    }
  }

  bool _isFinderPattern(int row, int col, int size) {
    // Top-left
    if (row < 7 && col < 7) {
      if (row == 0 || row == 6 || col == 0 || col == 6) return true;
      if (row >= 2 && row <= 4 && col >= 2 && col <= 4) return true;
      return false;
    }
    // Top-right
    if (row < 7 && col >= size - 7) {
      final c = col - (size - 7);
      if (row == 0 || row == 6 || c == 0 || c == 6) return true;
      if (row >= 2 && row <= 4 && c >= 2 && c <= 4) return true;
      return false;
    }
    // Bottom-left
    if (row >= size - 7 && col < 7) {
      final r = row - (size - 7);
      if (r == 0 || r == 6 || col == 0 || col == 6) return true;
      if (r >= 2 && r <= 4 && col >= 2 && col <= 4) return true;
      return false;
    }
    return false;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
