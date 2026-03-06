import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  BOTTOM SHEET HELPER
// ─────────────────────────────────────────────
class AppBottomSheet {
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool enableDrag = true,
    double? maxHeight,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        constraints: maxHeight != null
            ? BoxConstraints(maxHeight: maxHeight)
            : BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.9),
        decoration: BoxDecoration(
          color: isDark ? AppColors.dark800 : AppColors.light100,
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 24,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            const SizedBox(height: 12),
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.dark400 : AppColors.light400,
                  borderRadius: AppRadius.full,
                ),
              ),
            ),
            if (title != null) ...[
              const SizedBox(height: AppSpacing.md),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg),
                child: Text(title,
                    style: AppTextStyles.h2(isDark),
                    textAlign: TextAlign.center),
              ),
            ],
            Flexible(child: child),
            SizedBox(
              height: MediaQuery.of(ctx).viewInsets.bottom +
                  AppSpacing.md,
            ),
          ],
        ),
      ),
    );
  }
}
