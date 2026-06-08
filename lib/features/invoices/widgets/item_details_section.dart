import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/features/invoices/controllers/invoices_controller.dart';
import 'package:billkit/features/invoices/data/models/invoice_item_model.dart';
import 'add_item_bottom_sheet.dart';

class ItemDetailsSection extends StatelessWidget {
  final InvoicesController controller;
  const ItemDetailsSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'Item Details',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '*',
              style: TextStyle(
                color: Color(0xFF3B82F6),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              _ItemizationHeader(controller: controller),
              const SizedBox(height: 12),
              // Column headers
              const _ColumnHeaders(),
              const SizedBox(height: 4),
              // Divider
              const Divider(color: Color(0xFF2D3548), height: 1),
              const SizedBox(height: 4),
              // Item rows
              Obx(
                () => Column(
                  children: List.generate(
                    controller.items.length,
                    (index) => _InvoiceItemRow(
                      item: controller.items[index],
                      onDismissed: () => controller.removeItem(index),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ItemizationHeader extends StatelessWidget {
  final InvoicesController controller;
  const _ItemizationHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => Row(
            children: [
              Icon(
                controller.isItemized.value
                    ? Icons.grid_view_rounded
                    : Icons.view_list_rounded,
                color: const Color(0xFF94A3B8),
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                controller.isItemized.value
                    ? 'Itemization Matrix'
                    : 'Simple Mode',
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => _showAddItemDialog(context),
          child: const Row(
            children: [
              Icon(
                Icons.add_circle_outline_rounded,
                color: Color(0xFF3B82F6),
                size: 16,
              ),
              SizedBox(width: 4),
              Text(
                'Add Item',
                style: TextStyle(
                  color: Color(0xFF3B82F6),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showAddItemDialog(BuildContext context) {
    AddItemBottomSheet.show(context, controller);
  }
}

class _ColumnHeaders extends StatelessWidget {
  const _ColumnHeaders();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              'DESCRIPTION',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(
            width: 32,
            child: Text(
              'QTY',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(
            width: 56,
            child: Text(
              'PRICE',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(
            width: 36,
            child: Text(
              'TAX %',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InvoiceItemRow extends StatelessWidget {
  final InvoiceItem item;
  final VoidCallback onDismissed;

  const _InvoiceItemRow({required this.item, required this.onDismissed});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: const Color(0xFFE05353).withValues(alpha: 0.2),
        child: const Icon(Icons.delete_outline, color: Color(0xFFE05353)),
      ),
      onDismissed: (_) => onDismissed(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Text(
                item.description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              width: 32,
              child: Text(
                '${item.quantity}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              width: 56,
              child: Text(
                item.price.toStringAsFixed(1),
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              width: 36,
              child: Text(
                '${item.taxPercent.toInt()}',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
