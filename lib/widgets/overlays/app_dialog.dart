import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  CONFIRMATION DIALOG
// ─────────────────────────────────────────────
class AppDialog {
  static Future<bool?> showConfirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool isDangerous = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return showDialog<bool>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: isDark ? AppColors.dark700 : AppColors.light100,
            borderRadius: AppRadius.xl,
            boxShadow: AppShadows.cardDark,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon indicator
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (isDangerous ? AppColors.error : AppColors.orange500)
                      .withOpacity(0.12),
                ),
                child: Icon(
                  isDangerous
                      ? Icons.delete_outline_rounded
                      : Icons.help_outline_rounded,
                  color: isDangerous
                      ? AppColors.error
                      : AppColors.orange500,
                  size: 28,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(title,
                  style: AppTextStyles.h2(isDark),
                  textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.sm),
              Text(message,
                  style: AppTextStyles.bodyMedium(isDark),
                  textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.of(ctx).pop(false),
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.dark500
                              : AppColors.light300,
                          borderRadius: AppRadius.full,
                        ),
                        child: Center(
                          child: Text(cancelLabel,
                              style: AppTextStyles.labelLarge(isDark)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.of(ctx).pop(true),
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          gradient: isDangerous ? null
                              : AppGradients.orangePrimary,
                          color: isDangerous ? AppColors.error : null,
                          borderRadius: AppRadius.full,
                          boxShadow: isDangerous
                              ? [BoxShadow(
                                  color: AppColors.error.withOpacity(0.3),
                                  blurRadius: 12, offset: const Offset(0, 4))]
                              : AppShadows.orangeGlow,
                        ),
                        child: Center(
                          child: Text(
                            confirmLabel,
                            style: const TextStyle(
                              fontFamily: 'Sora',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
