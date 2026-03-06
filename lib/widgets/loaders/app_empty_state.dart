import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  EMPTY STATE
// ─────────────────────────────────────────────
class AppEmptyState extends StatelessWidget {
  final String title;
  final String description;
  final Widget? illustration;
  final String? actionLabel;
  final VoidCallback? onAction;

  const AppEmptyState({
    super.key,
    required this.title,
    required this.description,
    this.illustration,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            illustration ??
                Container(
                  width: 100, height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.orange500.withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.inbox_rounded,
                    size: 48,
                    color: AppColors.orange500,
                  ),
                ),
            const SizedBox(height: AppSpacing.lg),
            Text(title,
                style: AppTextStyles.h2(isDark),
                textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.sm),
            Text(description,
                style: AppTextStyles.bodyMedium(isDark),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis),
            if (actionLabel != null) ...[
              const SizedBox(height: AppSpacing.lg),
              GestureDetector(
                onTap: onAction,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28, vertical: 14),
                  decoration: BoxDecoration(
                    gradient: AppGradients.orangePrimary,
                    borderRadius: AppRadius.full,
                    boxShadow: AppShadows.orangeGlow,
                  ),
                  child: Text(
                    actionLabel!,
                    style: const TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
