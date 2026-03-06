import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  TAB BAR
// ─────────────────────────────────────────────
class AppTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const AppTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: isDark ? AppColors.dark700 : AppColors.light300,
        borderRadius: AppRadius.full,
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: tabs.asMap().entries.map((e) {
          final isActive = selectedIndex == e.key;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(e.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                decoration: BoxDecoration(
                  gradient: isActive ? AppGradients.orangePrimary : null,
                  borderRadius: AppRadius.full,
                  boxShadow: isActive ? AppShadows.orangeGlow : null,
                ),
                child: Center(
                  child: Text(
                    e.value,
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 13,
                      fontWeight:
                          isActive ? FontWeight.w600 : FontWeight.w400,
                      color: isActive
                          ? Colors.white
                          : isDark
                              ? AppColors.textDarkSecondary
                              : AppColors.textLightSecondary,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
