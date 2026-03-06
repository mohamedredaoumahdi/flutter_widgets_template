import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});
  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  bool _following = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppTopBar(title: 'Cards', showBack: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [

          _section('Stat Cards — with Sparklines', isDark),
          Row(children: [
            Expanded(child: StatCard(
              title: 'Revenue',
              value: '\$24.8K',
              changePercent: 18.4,
              subtitle: 'vs last month',
              icon: const Icon(Icons.attach_money_rounded),
              accentColor: AppColors.orange500,
              sparklineData: const [12, 19, 14, 22, 18, 28, 24],
            )),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: StatCard(
              title: 'Orders',
              value: '1,284',
              changePercent: 5.7,
              subtitle: 'this week',
              icon: const Icon(Icons.shopping_bag_outlined),
              accentColor: AppColors.info,
              sparklineData: const [8, 10, 7, 14, 12, 16, 13],
            )),
          ]),
          const SizedBox(height: AppSpacing.sm),
          Row(children: [
            Expanded(child: StatCard(
              title: 'Users',
              value: '18,920',
              changePercent: -3.2,
              subtitle: 'monthly active',
              icon: const Icon(Icons.people_outline_rounded),
              accentColor: AppColors.success,
              sparklineData: const [20, 18, 22, 17, 15, 16, 14],
            )),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: StatCard(
              title: 'Returns',
              value: '2.4%',
              changePercent: -0.8,
              subtitle: 'rate this month',
              icon: const Icon(Icons.refresh_rounded),
              accentColor: AppColors.warning,
            )),
          ]),

          _section('Horizontal Quick-Stat Strip', isDark),
          HorizontalCardList(cards: [
            const QuickStatCard(label: 'Revenue', value: '\$24K', icon: Icons.attach_money_rounded, color: AppColors.orange500),
            const QuickStatCard(label: 'Orders', value: '1,284', icon: Icons.shopping_bag_outlined, color: AppColors.info),
            const QuickStatCard(label: 'Users', value: '18.9K', icon: Icons.people_outline_rounded, color: AppColors.success),
            const QuickStatCard(label: 'Returns', value: '2.4%', icon: Icons.refresh_rounded, color: AppColors.warning),
          ]),

          _section('Feature / Highlight Cards', isDark),
          FeatureCard(
            title: 'Upgrade to Pro',
            description: 'Unlock unlimited access, advanced analytics, priority support and more.',
            icon: const Icon(Icons.star_rounded),
            actionLabel: 'Get started',
            tag: '🔥 Popular',
            onTap: () {},
          ),
          const SizedBox(height: AppSpacing.sm),
          FeatureCard(
            title: 'Flash Sale — 40% Off',
            description: 'Limited time offer on all premium plans. Ends in 2 days.',
            actionLabel: 'Claim offer',
            tag: '⏰ Ends soon',
            gradient: const LinearGradient(
              colors: [Color(0xFF7B2FF7), Color(0xFFE040FB)],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
            onTap: () {},
          ),

          _section('Image / Media Cards', isDark),
          ImageCard(
            title: 'Flutter 3.x New Features',
            subtitle: 'By Ahmed K · 5 min read',
            height: 200,
            placeholderColor: AppColors.orange700,
            badge: AppBadge(label: 'New', variant: BadgeVariant.primary, filled: true),
            onTap: () {},
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(children: [
            Expanded(child: ImageCard(
              title: 'Firebase Tips',
              subtitle: '3 min read',
              height: 140,
              placeholderColor: AppColors.info,
            )),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: ImageCard(
              title: 'UI Design Trends',
              subtitle: '7 min read',
              height: 140,
              placeholderColor: const Color(0xFF7B2FF7),
              badge: AppBadge(label: 'Pro', variant: BadgeVariant.warning, filled: true),
            )),
          ]),

          _section('List Item Cards', isDark),
          ...['Design System', 'Flutter SDK', 'Firebase', 'Figma Plugin'].asMap().entries.map((e) {
            final icons = [Icons.palette_rounded, Icons.flutter_dash, Icons.local_fire_department_rounded, Icons.design_services_rounded];
            final colors = [AppColors.orange500, AppColors.info, AppColors.warning, AppColors.success];
            final tags = ['v2.0', 'v3.22', 'v10', null];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: ListItemCard(
                leading: Container(width: 42, height: 42,
                  decoration: BoxDecoration(color: colors[e.key].withOpacity(0.12), borderRadius: AppRadius.md),
                  child: Icon(icons[e.key], color: colors[e.key], size: 20)),
                title: e.value,
                subtitle: 'Tap to open details',
                accentColor: colors[e.key],
                tag: tags[e.key],
                tagColor: colors[e.key],
                trailing: AppBadge(label: 'Active', variant: BadgeVariant.success),
                onTap: () {},
              ),
            );
          }),

          _section('Profile Card', isDark),
          ProfileCard(
            name: 'Ahmed Karim',
            role: 'Senior Flutter Developer',
            location: 'Agadir, Morocco',
            stats: const [
              ProfileCardStat('Posts', '142'),
              ProfileCardStat('Followers', '8.4K'),
              ProfileCardStat('Following', '312'),
            ],
            isFollowing: _following,
            onFollow: () => setState(() => _following = !_following),
          ),

          _section('Base Card', isDark),
          AppCard(
            onTap: () {},
            child: Row(children: [
              Container(width: 44, height: 44,
                decoration: const BoxDecoration(
                  gradient: AppGradients.orangePrimary,
                  borderRadius: AppRadius.md,
                ),
                child: const Icon(Icons.touch_app_rounded, color: Colors.white, size: 22)),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Tappable Base Card', style: AppTextStyles.h3(isDark)),
                Text('Press me — feel the scale animation', style: AppTextStyles.bodyMedium(isDark)),
              ])),
              Container(width: 28, height: 28,
                decoration: BoxDecoration(shape: BoxShape.circle,
                    color: isDark ? AppColors.dark500 : AppColors.light300),
                child: Icon(Icons.arrow_forward_ios_rounded, size: 12,
                    color: isDark ? AppColors.textDarkHint : AppColors.textLightHint)),
            ]),
          ),

          const SizedBox(height: 60),
        ],
      ),
    );
  }
}

Widget _section(String title, bool isDark) => Padding(
  padding: const EdgeInsets.only(top: AppSpacing.lg, bottom: AppSpacing.sm),
  child: Row(children: [
    Container(width: 3, height: 16,
        decoration: BoxDecoration(gradient: AppGradients.orangePrimary, borderRadius: AppRadius.full)),
    const SizedBox(width: 8),
    Text(title, style: AppTextStyles.h3(isDark)),
  ]),
);