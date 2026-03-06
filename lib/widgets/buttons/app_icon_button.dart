import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  ICON BUTTON
// ─────────────────────────────────────────────
class AppIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final bool filled;
  final double size;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.filled = false,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size, height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: filled ? AppGradients.orangePrimary : null,
          color: filled ? null : (isDark
              ? AppColors.dark600
              : AppColors.light300),
          boxShadow: filled ? AppShadows.orangeGlow : null,
        ),
        child: Center(child: icon),
      ),
    );
  }
}
