import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'app_nav_item.dart';

// ─────────────────────────────────────────────
//  BOTTOM NAVIGATION BAR
// ─────────────────────────────────────────────
class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<AppNavItem> items;
  final int? notificationIndex;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.notificationIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.dark800 : AppColors.light100,
        border: Border(
          top: BorderSide(
            color: isDark
                ? AppColors.dark400.withOpacity(0.5)
                : AppColors.light400,
            width: 0.5,
          ),
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                ),
              ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: items.asMap().entries.map((e) {
              final index = e.key;
              final item = e.value;
              final isActive = currentIndex == index;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(index),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOutBack,
                        width: isActive ? 52 : 36,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.orange500.withOpacity(0.15)
                              : Colors.transparent,
                          borderRadius: AppRadius.full,
                        ),
                        child: Center(
                          child: notificationIndex == index
                              ? Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Icon(
                                      isActive ? item.activeIcon : item.icon,
                                      size: 22,
                                      color: isActive
                                          ? AppColors.orange500
                                          : isDark
                                              ? AppColors.textDarkHint
                                              : AppColors.textLightHint,
                                    ),
                                    Positioned(
                                      top: -3, right: -3,
                                      child: Container(
                                        width: 8, height: 8,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.error,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Icon(
                                  isActive ? item.activeIcon : item.icon,
                                  size: 22,
                                  color: isActive
                                      ? AppColors.orange500
                                      : isDark
                                          ? AppColors.textDarkHint
                                          : AppColors.textLightHint,
                                ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 10,
                          fontWeight: isActive
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isActive
                              ? AppColors.orange500
                              : isDark
                                  ? AppColors.textDarkHint
                                  : AppColors.textLightHint,
                        ),
                        child: Text(item.label),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
