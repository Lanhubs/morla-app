import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morla/core/theme/app_colors.dart';

class PaymentChannelBtn extends StatelessWidget {
  final VoidCallback onTap;
  
  const PaymentChannelBtn({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
          color:  AppColors.primaryBlue.withValues(alpha: 0.1) ,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               
                  HugeIcon(icon:
                    HugeIcons.strokeRoundedMoneyAdd01,
                    color: AppColors.primaryBlue,
                    size: 24,
                  ),
                  const SizedBox(width: 16),

                   Text(
                      "Payment channel",
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize:16,
                        fontWeight:FontWeight.w700 ,
                        letterSpacing:2.0 ,
                        color:AppColors.primaryBlue ,
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