import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  RICH NOTIFICATION CARD  (new — inbox item)
// ─────────────────────────────────────────────
enum NotificationType { message, alert, promo, system, like }

class NotificationCard extends StatelessWidget {
  final NotificationType type;
  final String title;
  final String body;
  final String time;
  final bool isRead;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;
  final String? actionLabel;
  final VoidCallback? onAction;

  const NotificationCard({
    super.key,
    required this.type,
    required this.title,
    required this.body,
    required this.time,
    this.isRead = false,
    this.onTap,
    this.onDismiss,
    this.actionLabel,
    this.onAction,
  });

  Color get _typeColor => switch (type) {
    NotificationType.message => AppColors.info,
    NotificationType.alert   => AppColors.error,
    NotificationType.promo   => AppColors.orange500,
    NotificationType.system  => AppColors.warning,
    NotificationType.like    => const Color(0xFFE91E63),
  };

  IconData get _typeIcon => switch (type) {
    NotificationType.message => Icons.chat_bubble_rounded,
    NotificationType.alert   => Icons.warning_rounded,
    NotificationType.promo   => Icons.local_offer_rounded,
    NotificationType.system  => Icons.settings_rounded,
    NotificationType.like    => Icons.favorite_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isRead
              ? (isDark ? AppColors.dark700 : AppColors.light100)
              : (isDark
                  ? Color.alphaBlend(_typeColor.withOpacity(0.05), AppColors.dark700)
                  : Color.alphaBlend(_typeColor.withOpacity(0.04), AppColors.light100)),
          borderRadius: AppRadius.lg,
          border: Border.all(
            color: isRead
                ? (isDark ? AppColors.dark400.withOpacity(0.5) : AppColors.light400)
                : _typeColor.withOpacity(0.25),
            width: isRead ? 0.5 : 1,
          ),
          boxShadow: isDark ? AppShadows.cardDark : AppShadows.cardLight,
        ),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Icon circle
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(
              color: _typeColor.withOpacity(0.13),
              shape: BoxShape.circle,
            ),
            child: Icon(_typeIcon, color: _typeColor, size: 20),
          ),
          const SizedBox(width: AppSpacing.md),
          // Content
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(
                  child: Text(title,
                      style: AppTextStyles.h3(isDark).copyWith(
                        fontWeight: isRead ? FontWeight.w500 : FontWeight.w700,
                      )),
                ),
                const SizedBox(width: 8),
                Text(time, style: AppTextStyles.bodySmall(isDark)),
                if (!isRead) ...[
                  const SizedBox(width: 6),
                  Container(
                    width: 8, height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _typeColor,
                      boxShadow: [
                        BoxShadow(color: _typeColor.withOpacity(0.4),
                            blurRadius: 4, offset: const Offset(0, 1)),
                      ],
                    ),
                  ),
                ],
              ]),
              const SizedBox(height: 3),
              Text(body,
                  style: AppTextStyles.bodyMedium(isDark),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
              if (actionLabel != null) ...[
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: onAction,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: _typeColor.withOpacity(0.1),
                      borderRadius: AppRadius.full,
                      border: Border.all(color: _typeColor.withOpacity(0.3)),
                    ),
                    child: Text(actionLabel!,
                        style: TextStyle(
                          fontFamily: 'Sora', fontSize: 12,
                          fontWeight: FontWeight.w700, color: _typeColor,
                        )),
                  ),
                ),
              ],
            ]),
          ),
        ]),
      ),
    );
  }
}
