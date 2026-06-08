import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:billkit/routes/app_routes.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.white,

          backgroundImage: NetworkImage(
            'https://avatars.githubusercontent.com/u/12345678?v=4',
          ),
        ),
        const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        Spacer(),
        IconButton.filled(
          onPressed: () => Get.toNamed(AppRoutes.announcements),
          color: const Color(0xFF3B82F6).withValues(alpha: 0.05),
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedNotification01,
            color: Colors.white,
          ),
        ),
        
      ],
    );
  }
}
