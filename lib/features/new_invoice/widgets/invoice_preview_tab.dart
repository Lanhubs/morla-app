import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:billkit/core/widgets/cta_button.dart';
import 'package:billkit/features/new_invoice/controllers/new_invoice_controller.dart';

class InvoicePreviewTab extends StatelessWidget {
  final NewInvoiceController controller;
  const InvoicePreviewTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Obx(() => Html(
                data: _buildHtml(controller.signatureImagePath.value),
                style: {
                  "body": Style(
                    margin: Margins.all(16),
                    padding: HtmlPaddings.zero,
                    fontFamily: 'sans-serif',
                    color: const Color(0xFF0F172A),
                  ),
                  "table": Style(
                    width: Width(100, Unit.percent),
                  ),
                  "td": Style(
                    verticalAlign: VerticalAlign.top,
                  ),
                },
              )),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Obx(() {
          final hasSignature = controller.signatureImagePath.value.isNotEmpty;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlinedButton.icon(
                onPressed: () => controller.pickSignature(),
                icon: Icon(hasSignature ? Icons.edit : Icons.draw),
                label: Text(hasSignature ? 'Change Signature' : 'Attach Signature'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.white24),
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              CtaButton(
                text: controller.isCreating ? 'ISSUING...' : 'ISSUE INVOICE',
                onPressed: controller.isCreating
                    ? null
                    : () {
                        // Backend will handle signature processing
                        controller.saveInvoice(); 
                      },
                type: CtaButtonType.primary,
                width: double.infinity,
              ),
            ],
          );
        }),
      ],
    );
  }

  String _buildHtml(String signaturePath) {
    String signatureHtml = '<div style="font-size: 11px; margin-bottom: 32px;">Signature</div>';
    if (signaturePath.isNotEmpty) {
      signatureHtml = '<img src="file://$signaturePath" style="height: 60px; object-fit: contain; margin-bottom: 8px;" /><br><div style="font-size: 11px;">Signature</div>';
    }

    return """
    <div>
      <table width='100%' style='margin-bottom: 32px;'>
        <tr>
          <td valign='top' style='color: #2563EB; font-size: 16px; font-weight: bold; padding-top: 8px;'>Forge Energy</td>
          <td align='right' valign='top'>
            <div style='font-size: 32px; font-weight: 900; letter-spacing: -0.5px; line-height: 1.0; margin-bottom: 4px;'>Invoice</div>
            <div style='color: #2563EB; font-size: 14px; font-weight: 600;'>#INV-0044</div>
          </td>
        </tr>
      </table>

      <table width='100%' style='margin-bottom: 24px;'>
        <tr>
          <td valign='top' width='50%'>
            <div style='color: #475569; font-size: 12px; margin-bottom: 8px;'>Billed to</div>
            <div style='font-size: 12px; font-weight: bold; margin-bottom: 4px;'>Acme Corporation</div>
            <div style='color: #334155; font-size: 12px; line-height: 1.4;'>123 Business Rd, Suite 100<br>Tech City, CA 90210<br>billing@acmecorp.com<br>+1 (555) 123-4567</div>
          </td>
          <td align='right' valign='top' width='50%'>
            <div style='color: #334155; font-size: 12px; line-height: 1.4;'>Forge Energy Ltd.<br>456 Industrial Pkwy, NY 10001<br>hello@forgeenergy.com<br>+1 (800) 987-6543</div>
          </td>
        </tr>
      </table>

      <table width='100%' style='background-color: #EEF2FF; border-radius: 12px; margin-bottom: 24px;'>
        <tr>
          <td valign='top' style='padding: 16px;'>
            <div style='color: #64748B; font-size: 11px; margin-bottom: 4px;'>Due date</div>
            <div style='font-size: 12px; font-weight: bold;'>15 June, 2026</div>
          </td>
          <td valign='top' style='padding: 16px;'>
            <div style='color: #64748B; font-size: 11px; margin-bottom: 4px;'>Invoice date</div>
            <div style='font-size: 12px; font-weight: bold;'>1 June, 2026</div>
          </td>
          <td valign='top' style='padding: 16px;'>
            <div style='color: #64748B; font-size: 11px; margin-bottom: 4px;'>Reference</div>
            <div style='font-size: 12px; font-weight: bold;'>#INV-0044</div>
          </td>
        </tr>
      </table>

      <!-- Items Table -->
      <table width='100%' cellspacing='0' cellpadding='0' style='margin-bottom: 0;'>
        <tr style='background-color: #EEF2FF;'>
          <td style='padding: 12px 16px; color: #64748B; font-size: 11px; font-weight: bold; border-top-left-radius: 12px;'>Description</td>
          <td style='padding: 12px 16px; color: #64748B; font-size: 11px; font-weight: bold;'>Qty</td>
          <td align='right' style='padding: 12px 16px; color: #64748B; font-size: 11px; font-weight: bold;'>Rate</td>
          <td align='right' style='padding: 12px 16px; color: #64748B; font-size: 11px; font-weight: bold; border-top-right-radius: 12px;'>Amount</td>
        </tr>
        <tr>
          <td style='padding: 14px 16px; border-bottom: 1px solid #E2E8F0; font-size: 11px; font-weight: bold;'>Solar Panel Installation (10kW System)</td>
          <td style='padding: 14px 16px; border-bottom: 1px solid #E2E8F0; font-size: 11px;'>01</td>
          <td align='right' style='padding: 14px 16px; border-bottom: 1px solid #E2E8F0; font-size: 11px;'>\$3,000.00</td>
          <td align='right' style='padding: 14px 16px; border-bottom: 1px solid #E2E8F0; font-size: 11px;'>\$3,000.00</td>
        </tr>
        <tr>
          <td style='padding: 14px 16px; border-bottom: 1px solid #E2E8F0; font-size: 11px; font-weight: bold;'>Inverter & Battery Setup</td>
          <td style='padding: 14px 16px; border-bottom: 1px solid #E2E8F0; font-size: 11px;'>01</td>
          <td align='right' style='padding: 14px 16px; border-bottom: 1px solid #E2E8F0; font-size: 11px;'>\$1,500.00</td>
          <td align='right' style='padding: 14px 16px; border-bottom: 1px solid #E2E8F0; font-size: 11px;'>\$1,500.00</td>
        </tr>
      </table>

      <!-- Totals -->
      <table width='100%' cellspacing='0' cellpadding='0' style='background-color: #EEF2FF; margin-bottom: 48px; border-bottom-left-radius: 12px; border-bottom-right-radius: 12px;'>
        <tr>
          <td width='40%'></td>
          <td width='60%' style='padding: 16px;'>
            <table width='100%'>
              <tr>
                <td style='font-size: 11px; padding-bottom: 8px;'>Subtotal</td>
                <td align='right' style='font-size: 11px; padding-bottom: 8px;'>\$4,500.00</td>
              </tr>
              <tr>
                <td style='font-size: 11px; padding-bottom: 16px;'>Tax (10%)</td>
                <td align='right' style='font-size: 11px; padding-bottom: 16px;'>\$450.00</td>
              </tr>
              <tr>
                <td style='font-size: 11px; font-weight: bold;'>GRAND TOTAL</td>
                <td align='right' style='font-size: 11px; font-weight: bold;'>\$4,950.00</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>

      <table width='100%' cellspacing='0' cellpadding='0'>
        <tr>
          <td valign='bottom' width='55%' style='background-color: #EEF2FF; padding: 16px; border-radius: 12px;'>
            <div style='font-size: 12px; font-weight: bold; margin-bottom: 8px;'>Payment details</div>
            <div style='color: #475569; font-size: 11px; line-height: 1.4; margin-bottom: 16px;'>CHASE BANK<br>SWIFT: CHASUS33<br>Acct. #1234567890</div>
            <div style='border-top: 2px solid white; margin-bottom: 8px; padding-top: 8px;'></div>
            <div style='color: #475569; font-size: 11px;'>+1 (800) 987-6543 &nbsp;|&nbsp; billing@forgeenergy.com</div>
          </td>
          <td width='5%'></td>
          <td valign='bottom' align='right' width='40%'>
            <div style='border-top: 1px solid #94A3B8; margin-bottom: 4px; padding-top: 4px;'></div>
            \$signatureHtml
            <div style='font-size: 12px; font-weight: bold; margin-bottom: 4px;'>Thank you for the business!</div>
            <div style='color: #64748B; font-size: 10px;'>Please pay within 15 days of receiving this invoice.</div>
          </td>
        </tr>
      </table>
    </div>
    """;
  }
}
