import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});
  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _navIndex = 0;
  int _tabIndex = 0;
  int _tab2Index = 1;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppTopBar(title: 'Navigation', showBack: true),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
        notificationIndex: 2,
        items: const [
          AppNavItem(icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Home'),
          AppNavItem(icon: Icons.search_outlined, activeIcon: Icons.search_rounded, label: 'Search'),
          AppNavItem(icon: Icons.notifications_outlined, activeIcon: Icons.notifications_rounded, label: 'Alerts'),
          AppNavItem(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: 'Profile'),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [

          _section('Bottom Navigation Bar', isDark),
          AppCard(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Live preview below ↓', style: AppTextStyles.bodyMedium(isDark)),
              const SizedBox(height: AppSpacing.sm),
              Text('Current tab: ${["Home", "Search", "Alerts", "Profile"][_navIndex]}',
                  style: AppTextStyles.h3(isDark).copyWith(color: AppColors.orange500)),
              const SizedBox(height: AppSpacing.xs),
              Text('• Animated pill indicator\n• Notification dot on Alerts\n• Smooth icon transitions',
                  style: AppTextStyles.bodySmall(isDark)),
            ]),
          ),

          _section('Tab Bar — 3 Items', isDark),
          AppTabBar(
            tabs: const ['All', 'Active', 'Done'],
            selectedIndex: _tabIndex,
            onTap: (i) => setState(() => _tabIndex = i),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            child: Text('Selected: ${["All", "Active", "Done"][_tabIndex]}',
                style: AppTextStyles.bodyMedium(isDark)),
          ),

          _section('Tab Bar — 4 Items', isDark),
          AppTabBar(
            tabs: const ['Day', 'Week', 'Month', 'Year'],
            selectedIndex: _tab2Index,
            onTap: (i) => setState(() => _tab2Index = i),
          ),

          _section('App Bar Styles', isDark),
          Text('Standard (used above)', style: AppTextStyles.bodySmall(isDark)),
          const SizedBox(height: AppSpacing.sm),
          // Custom AppBar preview as a card
          AppCard(
            padding: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: AppRadius.lg,
              child: Container(
                height: 60,
                color: isDark ? AppColors.dark800 : AppColors.light100,
                child: Row(children: [
                  const SizedBox(width: 16),
                  Container(width: 36, height: 36,
                    decoration: BoxDecoration(shape: BoxShape.circle,
                        color: isDark ? AppColors.dark600 : AppColors.light300),
                    child: const Icon(Icons.arrow_back_rounded, size: 18)),
                  const Spacer(),
                  Text('Screen Title', style: AppTextStyles.h3(isDark)),
                  const Spacer(),
                  Container(width: 36, height: 36,
                    decoration: BoxDecoration(shape: BoxShape.circle,
                        color: isDark ? AppColors.dark600 : AppColors.light300),
                    child: const Icon(Icons.more_vert_rounded, size: 18)),
                  const SizedBox(width: 16),
                ]),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            padding: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: AppRadius.lg,
              child: Container(
                height: 60,
                decoration: const BoxDecoration(gradient: AppGradients.orangePrimary),
                child: Row(children: [
                  const SizedBox(width: 16),
                  const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 22),
                  const Spacer(),
                  const Text('Gradient Bar', style: TextStyle(
                      fontFamily: 'Sora', fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white)),
                  const Spacer(),
                  NotificationBadge(count: 4,
                    child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22)),
                  const SizedBox(width: 16),
                ]),
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

Widget _section(String title, bool isDark) => Padding(
  padding: const EdgeInsets.only(top: AppSpacing.lg, bottom: AppSpacing.sm),
  child: Row(children: [
    Container(width: 3, height: 16, decoration: BoxDecoration(gradient: AppGradients.orangePrimary, borderRadius: AppRadius.full)),
    const SizedBox(width: 8),
    Text(title, style: AppTextStyles.h3(isDark)),
  ]),
);