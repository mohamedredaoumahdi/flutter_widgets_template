import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  NOTIFICATION BADGE  (count on child)
// ─────────────────────────────────────────────
class NotificationBadge extends StatelessWidget {
  final Widget child;
  final int count;
  final bool showZero;
  final Color? color;

  const NotificationBadge({
    super.key,
    required this.child,
    required this.count,
    this.showZero = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final show = showZero ? true : count > 0;
    return Stack(clipBehavior: Clip.none, children: [
      child,
      if (show)
        Positioned(
          top: -5, right: -6,
          child: AnimatedScale(
            scale: show ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.elasticOut,
            child: Container(
              constraints: const BoxConstraints(minWidth: 20),
              height: 20,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: color ?? AppColors.error,
                borderRadius: AppRadius.full,
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: (color ?? AppColors.error).withOpacity(0.4),
                    blurRadius: 6, offset: const Offset(0, 2)),
                ],
              ),
              child: Center(
                child: Text(
                  count > 99 ? '99+' : '$count',
                  style: const TextStyle(
                    fontFamily: 'Sora', fontSize: 10,
                    fontWeight: FontWeight.w800, color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
    ]);
  }
}
