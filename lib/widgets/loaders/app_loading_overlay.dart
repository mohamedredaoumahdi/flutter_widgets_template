import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  LOADING OVERLAY
// ─────────────────────────────────────────────
class AppLoadingOverlay extends StatelessWidget {
  final String? message;

  const AppLoadingOverlay({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl, vertical: AppSpacing.lg),
          decoration: BoxDecoration(
            color: isDark ? AppColors.dark700 : AppColors.light100,
            borderRadius: AppRadius.xl,
            boxShadow: AppShadows.cardDark,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 40, height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  strokeCap: StrokeCap.round,
                  valueColor:
                      const AlwaysStoppedAnimation(AppColors.orange500),
                ),
              ),
              if (message != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(message!,
                    style: AppTextStyles.bodyMedium(isDark),
                    textAlign: TextAlign.center),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
