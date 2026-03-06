import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'buttons_screen.dart';
import 'cards_screen.dart';
import 'inputs_screen.dart';
import 'avatars_screen.dart';
import 'navigation_screen.dart';
import 'loaders_screen.dart';
import 'overlays_screen.dart';
import 'typography_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDark;

  const HomeScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDark,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<_WidgetCategory> _categories = [
    _WidgetCategory(
      title: 'Buttons & CTAs',
      description: 'Primary, secondary, ghost, danger, icon buttons & FAB',
      icon: Icons.smart_button_rounded,
      color: AppColors.orange500,
      screen: const ButtonsScreen(),
      count: 8,
    ),
    _WidgetCategory(
      title: 'Cards',
      description: 'Base, stat, feature highlight and list item cards',
      icon: Icons.dashboard_rounded,
      color: AppColors.info,
      screen: const CardsScreen(),
      count: 5,
    ),
    _WidgetCategory(
      title: 'Forms & Inputs',
      description: 'Text fields, search bar, dropdown, toggles',
      icon: Icons.edit_rounded,
      color: AppColors.success,
      screen: const InputsScreen(),
      count: 7,
    ),
    _WidgetCategory(
      title: 'Avatars, Badges & Chips',
      description: 'Avatars, avatar groups, badges, chips and tags',
      icon: Icons.person_rounded,
      color: AppColors.warning,
      screen: const AvatarsBadgesScreen(),
      count: 9,
    ),
    _WidgetCategory(
      title: 'Navigation',
      description: 'App bar, bottom nav and animated tab bar',
      icon: Icons.explore_rounded,
      color: Color(0xFF9C27B0),
      screen: const NavigationScreen(),
      count: 3,
    ),
    _WidgetCategory(
      title: 'Loaders & Progress',
      description: 'Shimmer, progress bars, circular progress, empty states',
      icon: Icons.hourglass_top_rounded,
      color: AppColors.orange600,
      screen: const LoadersScreen(),
      count: 6,
    ),
    _WidgetCategory(
      title: 'Dialogs & Overlays',
      description: 'Snackbars, dialogs, bottom sheets, dividers',
      icon: Icons.layers_rounded,
      color: AppColors.error,
      screen: const OverlaysScreen(),
      count: 5,
    ),
    _WidgetCategory(
      title: 'Typography & Colors',
      description: 'Type scale, color palette, gradients, radius tokens',
      icon: Icons.palette_rounded,
      color: AppColors.info,
      screen: const TypographyScreen(),
      count: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;

    return Scaffold(
      appBar: AppTopBar(
        showBack: false,
        titleWidget: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 30, height: 30,
              decoration: const BoxDecoration(
                gradient: AppGradients.orangePrimary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.widgets_rounded, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 8),
            Text('Widget Library', style: AppTextStyles.h2(isDark)),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: widget.onThemeToggle,
            child: Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? AppColors.dark700 : AppColors.light300,
              ),
              child: Icon(
                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                size: 20, color: AppColors.orange500,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [

          // Header banner
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              gradient: AppGradients.orangePrimary,
              borderRadius: AppRadius.xl,
              boxShadow: AppShadows.orangeGlow,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Orange UI Kit', style: const TextStyle(
                          fontFamily: 'Sora', fontSize: 22,
                          fontWeight: FontWeight.w700, color: Colors.white)),
                      const SizedBox(height: 4),
                      Text('${_categories.length} widget categories · Dark & Light',
                          style: TextStyle(fontFamily: 'Sora', fontSize: 13,
                              color: Colors.white.withOpacity(0.8))),
                      const SizedBox(height: AppSpacing.md),
                      Row(children: [
                        AppBadge(label: 'Flutter 3.x', variant: BadgeVariant.neutral),
                        const SizedBox(width: 6),
                        AppBadge(label: 'Material 3', variant: BadgeVariant.neutral),
                      ]),
                    ],
                  ),
                ),
                Container(
                  width: 64, height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: AppRadius.xl,
                  ),
                  child: const Icon(Icons.widgets_rounded, color: Colors.white, size: 32),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Categories', style: AppTextStyles.h2(isDark)),
              AppBadge(
                label: '${_categories.length} screens',
                variant: BadgeVariant.primary,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Category grid
          ...List.generate(_categories.length, (i) {
            final cat = _categories[i];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _CategoryTile(
                category: cat,
                isDark: isDark,
                onTap: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, anim, __) => cat.screen,
                    transitionsBuilder: (_, anim, __, child) => SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1, 0), end: Offset.zero,
                      ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
                      child: child,
                    ),
                    transitionDuration: const Duration(milliseconds: 300),
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final _WidgetCategory category;
  final bool isDark;
  final VoidCallback onTap;

  const _CategoryTile({
    required this.category,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isDark ? AppColors.dark700 : AppColors.light100,
          borderRadius: AppRadius.lg,
          border: Border.all(
            color: isDark
                ? AppColors.dark400.withOpacity(0.5)
                : AppColors.light400,
            width: 0.5,
          ),
          boxShadow: isDark ? AppShadows.cardDark : AppShadows.cardLight,
        ),
        child: Row(
          children: [
            Container(
              width: 52, height: 52,
              decoration: BoxDecoration(
                color: category.color.withOpacity(0.12),
                borderRadius: AppRadius.md,
              ),
              child: Icon(category.icon, color: category.color, size: 26),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category.title, style: AppTextStyles.h3(isDark)),
                  const SizedBox(height: 3),
                  Text(category.description,
                      style: AppTextStyles.bodySmall(isDark),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: category.color.withOpacity(0.12),
                    borderRadius: AppRadius.full,
                  ),
                  child: Text('${category.count}',
                      style: TextStyle(
                          fontFamily: 'Sora', fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: category.color)),
                ),
                const SizedBox(height: 4),
                Icon(Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: isDark ? AppColors.textDarkHint : AppColors.textLightHint),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WidgetCategory {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final Widget screen;
  final int count;

  const _WidgetCategory({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.screen,
    required this.count,
  });
}