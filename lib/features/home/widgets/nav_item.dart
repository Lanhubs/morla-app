import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class NavItem extends StatelessWidget {
  final String title;
  final dynamic icon;
  final void Function()? onTap;
  final bool isActive;
  const NavItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: Column(
         
          children: [
            if (icon is IconData)
              Icon(
                icon,
                size: 24.0,
                color: isActive ? Color(0xFF3B82F6) : Colors.white,
              )
            else if (icon is Widget || icon is List<List<dynamic>>)
              HugeIcon(
                icon: icon,
                size: 24.0,
                color: isActive ? Color(0xFF3B82F6) : Colors.white,
              ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.0,
                color: isActive ? Color(0xFF3B82F6) : Colors.white,
              ),
            ),
            SizedBox(height: 4.0,),
            isActive?
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: isActive ? Color(0xFF3B82F6) : Colors.white,
                shape: BoxShape.circle,
              ),
            ): SizedBox(height: 4.0,),
          ],
        ),
      ),
    );
  }
}
