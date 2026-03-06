import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  BADGE  (status pill)
// ─────────────────────────────────────────────
enum BadgeVariant { primary, success, warning, error, info, neutral }

class AppBadge extends StatelessWidget {
  final String label;
  final BadgeVariant variant;
  final bool dot;
  final bool filled;

  const AppBadge({
    super.key,
    required this.label,
    this.variant = BadgeVariant.primary,
    this.dot = false,
    this.filled = false,
  });

  Color get _color => switch (variant) {
    BadgeVariant.primary => AppColors.orange500,
    BadgeVariant.success => AppColors.success,
    BadgeVariant.warning => AppColors.warning,
    BadgeVariant.error   => AppColors.error,
    BadgeVariant.info    => AppColors.info,
    BadgeVariant.neutral => const Color(0xFF9E9E9E),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: filled ? _color : _color.withOpacity(0.13),
        borderRadius: AppRadius.full,
        border: filled ? null : Border.all(color: _color.withOpacity(0.3), width: 0.5),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (dot) ...[
          Container(
            width: 6, height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: filled ? Colors.white : _color,
            ),
          ),
          const SizedBox(width: 5),
        ],
        Text(label,
            style: TextStyle(
              fontFamily: 'Sora', fontSize: 11, fontWeight: FontWeight.w700,
              color: filled ? Colors.white : _color,
            )),
      ]),
    );
  }
}
