import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  PROGRESS BAR
// ─────────────────────────────────────────────
class AppProgressBar extends StatelessWidget {
  final double value; // 0.0 to 1.0
  final double height;
  final Color? trackColor;
  final bool showLabel;
  final String? label;

  const AppProgressBar({
    super.key,
    required this.value,
    this.height = 8,
    this.trackColor,
    this.showLabel = false,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final clampedValue = value.clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLabel) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (label != null)
                Text(label!, style: AppTextStyles.bodySmall(isDark)),
              Text(
                '${(clampedValue * 100).toInt()}%',
                style: TextStyle(
                  fontFamily: 'Sora', fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.orange500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
        ],
        LayoutBuilder(builder: (ctx, constraints) {
          return Stack(
            children: [
              Container(
                width: constraints.maxWidth,
                height: height,
                decoration: BoxDecoration(
                  color: trackColor ??
                      (isDark ? AppColors.dark500 : AppColors.light400),
                  borderRadius: AppRadius.full,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                width: constraints.maxWidth * clampedValue,
                height: height,
                decoration: BoxDecoration(
                  gradient: AppGradients.orangePrimary,
                  borderRadius: AppRadius.full,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.orange500.withOpacity(0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
