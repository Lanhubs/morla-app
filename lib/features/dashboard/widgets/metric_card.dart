import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:get/get.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final dynamic icon;
  final String? status;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xFF1E293B),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFF2A3F5F), width: 1),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: Get.width * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 45,
              height: 45,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: icon is IconData
                  ? Icon(icon, size: 17, color: const Color(0xFF3B82F6))
                  : HugeIcon(
                      icon: icon as List<List<dynamic>>,
                      size: 17,
                      color: const Color(0xFF3B82F6),
                    ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 150,
                  ), // 2. Added maxWidth constraint
                  child: Column(
                    spacing: 4,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        value,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: status == "pending" || status == "unpaid"
                        ? Colors.red.withValues(alpha: 0.1)
                        : Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "5.2% this month",
                    style: TextStyle(
                      fontSize: 12,
                      color: status == "pending" || status == "unpaid"
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
