import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  PROFILE CARD
// ─────────────────────────────────────────────
class ProfileCardStat {
  final String label;
  final String value;
  const ProfileCardStat(this.label, this.value);
}

class ProfileCard extends StatelessWidget {
  final String name;
  final String role;
  final String? location;
  final List<ProfileCardStat> stats;
  final VoidCallback? onFollow;
  final bool isFollowing;

  const ProfileCard({
    super.key,
    required this.name,
    required this.role,
    this.location,
    this.stats = const [],
    this.onFollow,
    this.isFollowing = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.dark700 : AppColors.light100,
        borderRadius: AppRadius.xl,
        border: Border.all(
          color: isDark ? AppColors.dark400.withOpacity(0.6) : AppColors.light400,
          width: 0.5,
        ),
        boxShadow: isDark ? AppShadows.cardDark : AppShadows.cardLight,
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        // Gradient banner
        Container(
          height: 64,
          decoration: BoxDecoration(
            gradient: AppGradients.orangePrimary,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Stack(children: [
            Positioned(right: -10, top: -10,
              child: Container(width: 80, height: 80,
                  decoration: BoxDecoration(shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.08)))),
          ]),
        ),
        Transform.translate(
          offset: const Offset(0, -28),
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark ? AppColors.dark700 : AppColors.light100,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.orange500.withOpacity(0.3),
                    blurRadius: 14, offset: const Offset(0, 4)),
                ],
              ),
              child: CircleAvatar(
                radius: 32,
                backgroundColor: AppColors.orange600,
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : '?',
                  style: const TextStyle(
                    fontFamily: 'Sora', fontSize: 24,
                    fontWeight: FontWeight.w800, color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(name, style: AppTextStyles.h2(isDark)),
            const SizedBox(height: 2),
            Text(role, style: AppTextStyles.bodyMedium(isDark)),
            if (location != null) ...[
              const SizedBox(height: 4),
              Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.location_on_rounded, size: 12,
                    color: isDark ? AppColors.textDarkHint : AppColors.textLightHint),
                const SizedBox(width: 2),
                Text(location!, style: AppTextStyles.bodySmall(isDark)),
              ]),
            ],
            if (stats.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.dark600 : AppColors.light200,
                    borderRadius: AppRadius.lg,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: stats.expand((s) => [
                      _statItem(s.label, s.value, isDark),
                      if (s != stats.last)
                        Container(width: 1, height: 28,
                            color: isDark ? AppColors.dark400 : AppColors.light400),
                    ]).toList(),
                  ),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            if (onFollow != null)
              GestureDetector(
                onTap: onFollow,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 11),
                  decoration: BoxDecoration(
                    gradient: isFollowing ? null : AppGradients.orangePrimary,
                    color: isFollowing ? (isDark ? AppColors.dark500 : AppColors.light300) : null,
                    borderRadius: AppRadius.full,
                    boxShadow: isFollowing ? [] : AppShadows.orangeGlow,
                    border: isFollowing
                        ? Border.all(color: isDark ? AppColors.dark400 : AppColors.light400)
                        : null,
                  ),
                  child: Text(
                    isFollowing ? '✓  Following' : 'Follow',
                    style: TextStyle(
                      fontFamily: 'Sora', fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isFollowing
                          ? (isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary)
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: AppSpacing.lg),
          ]),
        ),
      ]),
    );
  }

  Widget _statItem(String label, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(value, style: const TextStyle(
            fontFamily: 'Sora', fontSize: 16, fontWeight: FontWeight.w800,
            color: AppColors.orange500)),
        const SizedBox(height: 2),
        Text(label, style: AppTextStyles.bodySmall(isDark)),
      ]),
    );
  }
}
