import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  FLOATING ACTION BUTTON
// ─────────────────────────────────────────────
class AppFAB extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;
  final String? label;

  const AppFAB({
    super.key,
    required this.icon,
    this.onPressed,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 56,
        padding: EdgeInsets.symmetric(
            horizontal: label != null ? 20 : 0),
        width: label != null ? null : 56,
        decoration: BoxDecoration(
          gradient: AppGradients.orangePrimary,
          borderRadius: AppRadius.full,
          boxShadow: AppShadows.orangeGlow,
        ),
        child: label != null
            ? Row(mainAxisSize: MainAxisSize.min, children: [
                icon,
                const SizedBox(width: 8),
                Text(label!,
                    style: const TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    )),
              ])
            : Center(child: icon),
      ),
    );
  }
}
