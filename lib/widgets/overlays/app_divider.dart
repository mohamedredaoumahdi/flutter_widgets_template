import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  DIVIDER WITH LABEL
// ─────────────────────────────────────────────
class AppDivider extends StatelessWidget {
  final String? label;

  const AppDivider({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark ? AppColors.dark400 : AppColors.light400;

    if (label == null) {
      return Divider(color: color, thickness: 0.5, height: 1);
    }

    return Row(
      children: [
        Expanded(child: Divider(color: color, thickness: 0.5)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Text(label!, style: AppTextStyles.bodySmall(isDark)),
        ),
        Expanded(child: Divider(color: color, thickness: 0.5)),
      ],
    );
  }
}
