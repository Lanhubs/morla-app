import 'package:flutter/material.dart';

class TrackedBalance extends StatelessWidget {
  final String balance;
  const TrackedBalance({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Text(
            "TRACKED BALANCE >", 
            style: TextStyle(
              color: Colors.white70,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            balance,
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
