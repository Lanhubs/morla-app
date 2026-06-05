import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morla/routes/app_routes.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});
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
        padding: const EdgeInsets.all(23),
        width: Get.width ,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: ()=> Get.toNamed(AppRoutes.newClient),
              child: SizedBox(
                child: Column(
                  spacing: 9,
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
                      child: const Icon(
                        Icons.add,
                        size: 17,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "New Client",
                      style: TextStyle(
                        fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () {},
              child: SizedBox(
                child: Column(
                  spacing: 9,
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
                      child: const HugeIcon(
                        icon: HugeIcons.strokeRoundedInvoice03,
                        size: 17,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "Send Invoice",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: SizedBox(
                child: Column(
                  spacing: 9,
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
                      child: const HugeIcon(
                        icon: HugeIcons.strokeRoundedShare01,
                        size: 17,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "Share Link",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
