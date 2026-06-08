import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:billkit/core/theme/app_colors.dart';

enum CtaButtonType {
  primary,
  secondary,
  outlined,
  light,
  danger,
  secondaryBlue,
}

enum RadiusType { full, regular, none }

class CtaButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final dynamic icon;
  final CtaButtonType type;
  final RadiusType radius;
  final double? width;

  const CtaButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.type = CtaButtonType.primary,
    this.radius = RadiusType.regular,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final actualWidth =
            width ??
            (constraints.maxWidth == double.infinity ? null : double.infinity);

        return InkWell(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              color: type == CtaButtonType.primary
                  ? Get.theme.primaryColor.withValues(
                      alpha: onPressed == null ? 0.5 : 1.0,
                    )
                  : type == CtaButtonType.danger
                  ? AppColors.alertRed
                  : type == CtaButtonType.secondary
                  ? Get.theme.colorScheme.secondary.withValues(
                      alpha: onPressed == null ? 0.2 : 0.4,
                    )
                  : type == CtaButtonType.secondaryBlue
                  ? Colors.transparent
                  : type == CtaButtonType.light
                  ? Get.theme.colorScheme.surface.withValues(
                      alpha: onPressed == null ? 0.5 : 1.0,
                    )
                  : Colors.transparent,
              borderRadius: radius == RadiusType.full
                  ? BorderRadius.circular(100)
                  : radius == RadiusType.regular
                  ? BorderRadius.circular(14)
                  : BorderRadius.zero,
              border: type == CtaButtonType.outlined
                  ? Border.all(
                      color: Colors.white.withValues(
                        alpha: onPressed == null ? 0.5 : 1.0,
                      ),
                      width: 1,
                    )
                  : type == CtaButtonType.secondaryBlue
                  ? Border.all(color: AppColors.primaryBlue, width: 1)
                  : null,
            ),
            height: 56,
            width: actualWidth,
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: type == CtaButtonType.primary
                        ? Colors.white.withValues(
                            alpha: onPressed == null ? 0.7 : 1.0,
                          )
                        : type == CtaButtonType.light
                        ? Get.theme.colorScheme.primary.withValues(
                            alpha: onPressed == null ? 0.7 : 1.0,
                          )
                        : type == CtaButtonType.secondaryBlue
                        ? Get.theme.primaryColor
                        : Colors.white.withValues(
                            alpha: onPressed == null ? 0.7 : 1.0,
                          ),
                  ),
                ),
                if (icon != null) const SizedBox(width: 8),
                if (icon != null)
                  icon is String
                      ? SvgPicture.asset(
                          icon,
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                            Colors.white.withValues(
                              alpha: onPressed == null ? 0.7 : 1.0,
                            ),
                            BlendMode.srcIn,
                          ),
                        )
                      : icon is IconData
                      ? Icon(
                          icon,
                          size: 24,
                          color: Colors.white.withValues(
                            alpha: onPressed == null ? 0.7 : 1.0,
                          ),
                        )
                      : HugeIcon(
                          icon: icon,
                          size: 24,
                          color: Colors.white.withValues(
                            alpha: onPressed == null ? 0.7 : 1.0,
                          ),
                        ),
              ],
            ),
          ),
        );
      },
    );
  }
}
