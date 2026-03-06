import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class AvatarsBadgesScreen extends StatefulWidget {
  const AvatarsBadgesScreen({super.key});
  @override
  State<AvatarsBadgesScreen> createState() => _AvatarsBadgesScreenState();
}

class _AvatarsBadgesScreenState extends State<AvatarsBadgesScreen> {
  final Set<int> _selectedChips = {0};
  final List<bool> _readMap = [false, false, true, false, true];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppTopBar(title: 'Avatars, Badges & Notifications', showBack: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [

          _section('Avatar Sizes', isDark),
          AppCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _avatarCol(context, 'XS', const AppAvatar(name: 'XS', size: AvatarSize.xs)),
                _avatarCol(context, 'SM', const AppAvatar(name: 'Sara M', size: AvatarSize.sm)),
                _avatarCol(context, 'MD', const AppAvatar(name: 'John D', size: AvatarSize.md, status: AvatarStatus.online)),
                _avatarCol(context, 'LG', const AppAvatar(name: 'Ali K', size: AvatarSize.lg, status: AvatarStatus.away)),
                _avatarCol(context, 'XL', const AppAvatar(name: 'Wang L', size: AvatarSize.xl, status: AvatarStatus.busy)),
              ],
            ),
          ),

          _section('Status Indicators (with pulse animation)', isDark),
          AppCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _statusCol(context, 'Online',
                    const AppAvatar(name: 'Anna', size: AvatarSize.lg, status: AvatarStatus.online)),
                _statusCol(context, 'Away',
                    const AppAvatar(name: 'Bob', size: AvatarSize.lg, status: AvatarStatus.away)),
                _statusCol(context, 'Busy',
                    const AppAvatar(name: 'Cam', size: AvatarSize.lg, status: AvatarStatus.busy)),
                _statusCol(context, 'Offline',
                    const AppAvatar(name: 'Dan', size: AvatarSize.lg, status: AvatarStatus.offline)),
              ],
            ),
          ),

          _section('Gradient Ring Avatars', isDark),
          AppCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _avatarCol(context, 'Gradient',
                    const AppAvatar(name: 'Ahmed', size: AvatarSize.lg, gradientBorder: true, status: AvatarStatus.online)),
                _avatarCol(context, 'Orange',
                    AppAvatar(name: 'Sara', size: AvatarSize.lg, borderColor: AppColors.orange500)),
                _avatarCol(context, 'Blue',
                    AppAvatar(name: 'Mia', size: AvatarSize.lg, borderColor: AppColors.info)),
                _avatarCol(context, 'Green',
                    AppAvatar(name: 'Liu', size: AvatarSize.lg, borderColor: AppColors.success)),
              ],
            ),
          ),

          _section('Avatar Groups', isDark),
          AppCard(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Default (stacked)', style: AppTextStyles.bodyMedium(isDark)),
              const SizedBox(height: AppSpacing.sm),
              AppAvatarGroup(
                images: List.filled(7, null),
                names: ['Alice', 'Bob', 'Carol', 'Dave', 'Eve', 'Frank', 'Grace'],
                size: AvatarSize.sm,
              ),
              const SizedBox(height: AppSpacing.md),
              Text('With label', style: AppTextStyles.bodyMedium(isDark)),
              const SizedBox(height: AppSpacing.sm),
              AppAvatarGroup(
                images: List.filled(12, null),
                names: List.generate(12, (i) => 'User ${i + 1}'),
                size: AvatarSize.sm,
                maxVisible: 5,
                showLabel: true,
                label: 'and 7 others liked this',
              ),
              const SizedBox(height: AppSpacing.md),
              Text('Large avatars', style: AppTextStyles.bodyMedium(isDark)),
              const SizedBox(height: AppSpacing.sm),
              AppAvatarGroup(
                images: List.filled(4, null),
                names: ['Tom', 'Sam', 'Lisa', 'Mia'],
                size: AvatarSize.md,
                maxVisible: 3,
                showLabel: true,
              ),
            ]),
          ),

          _section('Notification Badges', isDark),
          AppCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(mainAxisSize: MainAxisSize.min, children: [
                  NotificationBadge(count: 3,
                      child: const Icon(Icons.notifications_rounded, size: 30, color: AppColors.orange500)),
                  const SizedBox(height: 6),
                  Text('3', style: AppTextStyles.bodySmall(isDark)),
                ]),
                Column(mainAxisSize: MainAxisSize.min, children: [
                  NotificationBadge(count: 12,
                      child: const Icon(Icons.chat_bubble_rounded, size: 30, color: AppColors.info)),
                  const SizedBox(height: 6),
                  Text('12', style: AppTextStyles.bodySmall(isDark)),
                ]),
                Column(mainAxisSize: MainAxisSize.min, children: [
                  NotificationBadge(count: 99,
                      child: const Icon(Icons.email_rounded, size: 30, color: AppColors.success)),
                  const SizedBox(height: 6),
                  Text('99', style: AppTextStyles.bodySmall(isDark)),
                ]),
                Column(mainAxisSize: MainAxisSize.min, children: [
                  NotificationBadge(count: 150,
                      child: const Icon(Icons.shopping_cart_rounded, size: 30, color: AppColors.warning)),
                  const SizedBox(height: 6),
                  Text('99+', style: AppTextStyles.bodySmall(isDark)),
                ]),
                Column(mainAxisSize: MainAxisSize.min, children: [
                  NotificationBadge(count: 5, color: AppColors.orange500,
                      child: const AppAvatar(name: 'A', size: AvatarSize.md)),
                  const SizedBox(height: 6),
                  Text('on avatar', style: AppTextStyles.bodySmall(isDark)),
                ]),
              ],
            ),
          ),

          _section('Rich Notification Cards', isDark),
          ...List.generate(5, (i) {
            final types = [
              NotificationType.message,
              NotificationType.promo,
              NotificationType.alert,
              NotificationType.like,
              NotificationType.system,
            ];
            final titles = [
              'New message from Sara',
              'Flash Sale — 40% Off',
              'Login attempt detected',
              'Ahmed liked your post',
              'App update available',
            ];
            final bodies = [
              'Hey! Are you free to review the design system today?',
              'All premium plans are 40% off for the next 24 hours only.',
              'A login attempt was made from a new device in Casablanca.',
              'Ahmed Karim and 12 others liked your "Flutter Tips" post.',
              'Version 2.4.0 is ready with new features and bug fixes.',
            ];
            final times = ['2m ago', '1h ago', '3h ago', '5h ago', '1d ago'];
            final actions = ['Reply', 'View offer', 'Secure account', null, 'Update now'];

            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: GestureDetector(
                onTap: () => setState(() => _readMap[i] = true),
                child: NotificationCard(
                  type: types[i],
                  title: titles[i],
                  body: bodies[i],
                  time: times[i],
                  isRead: _readMap[i],
                  actionLabel: actions[i],
                  onAction: () => setState(() => _readMap[i] = true),
                  onTap: () => setState(() => _readMap[i] = true),
                ),
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Center(
              child: Text('Tap any card to mark as read',
                  style: AppTextStyles.bodySmall(isDark)),
            ),
          ),

          _section('Status Badges', isDark),
          Wrap(spacing: 8, runSpacing: 8, children: [
            AppBadge(label: 'Active', variant: BadgeVariant.success, dot: true),
            AppBadge(label: 'Pending', variant: BadgeVariant.warning, dot: true),
            AppBadge(label: 'Cancelled', variant: BadgeVariant.error, dot: true),
            AppBadge(label: 'Pro', variant: BadgeVariant.primary, filled: true),
            AppBadge(label: 'Info', variant: BadgeVariant.info),
            AppBadge(label: 'Archived', variant: BadgeVariant.neutral),
            AppBadge(label: 'New', variant: BadgeVariant.primary),
            AppBadge(label: 'Failed', variant: BadgeVariant.error, filled: true),
          ]),

          _section('Chips (Selectable)', isDark),
          Wrap(spacing: 8, runSpacing: 8,
            children: ['All', 'Design', 'Flutter', 'Firebase', 'Dart', 'UI/UX']
                .asMap().entries.map((e) => AppChip(
                  label: e.value,
                  selected: _selectedChips.contains(e.key),
                  onTap: () => setState(() {
                    if (_selectedChips.contains(e.key)) {
                      _selectedChips.remove(e.key);
                    } else {
                      _selectedChips.add(e.key);
                    }
                  }),
                )).toList(),
          ),

          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _avatarCol(BuildContext context, String label, Widget avatar) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      avatar,
      const SizedBox(height: 6),
      Text(label, style: AppTextStyles.bodySmall(isDark)),
    ]);
  }

  Widget _statusCol(BuildContext context, String label, Widget avatar) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      avatar,
      const SizedBox(height: 8),
      Text(label,
          style: AppTextStyles.bodySmall(isDark).copyWith(fontWeight: FontWeight.w500)),
    ]);
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