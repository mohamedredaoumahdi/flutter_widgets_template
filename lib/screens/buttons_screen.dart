import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class ButtonsScreen extends StatefulWidget {
  const ButtonsScreen({super.key});
  @override
  State<ButtonsScreen> createState() => _ButtonsScreenState();
}

class _ButtonsScreenState extends State<ButtonsScreen> {
  bool _loading = false;

  void _simulateLoad() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppTopBar(title: 'Buttons & CTAs', showBack: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [

          _section('Variants', isDark),
          AppButton(label: 'Primary Button', onPressed: () {}, fullWidth: true),
          const SizedBox(height: AppSpacing.sm),
          AppButton(label: 'Secondary Button', variant: AppButtonVariant.secondary, onPressed: () {}, fullWidth: true),
          const SizedBox(height: AppSpacing.sm),
          AppButton(label: 'Ghost Button', variant: AppButtonVariant.ghost, onPressed: () {}, fullWidth: true),
          const SizedBox(height: AppSpacing.sm),
          AppButton(label: 'Danger Button', variant: AppButtonVariant.danger, onPressed: () {}, fullWidth: true),
          const SizedBox(height: AppSpacing.sm),
          AppButton(label: 'Disabled Button', onPressed: null, fullWidth: true),

          _section('Sizes', isDark),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppButton(label: 'Small', size: AppButtonSize.small, onPressed: () {}),
              AppButton(label: 'Medium', size: AppButtonSize.medium, onPressed: () {}),
              AppButton(label: 'Large', size: AppButtonSize.large, onPressed: () {}),
            ],
          ),

          _section('With Icons', isDark),
          AppButton(
            label: 'Leading Icon',
            leadingIcon: const Icon(Icons.rocket_launch_rounded, size: 16, color: Colors.white),
            onPressed: () {},
            fullWidth: true,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: 'Trailing Icon',
            trailingIcon: const Icon(Icons.arrow_forward_rounded, size: 16, color: AppColors.orange500),
            variant: AppButtonVariant.secondary,
            onPressed: () {},
            fullWidth: true,
          ),

          _section('Loading State', isDark),
          AppButton(
            label: 'Tap to simulate loading',
            isLoading: _loading,
            onPressed: _simulateLoad,
            fullWidth: true,
          ),

          _section('Icon Buttons', isDark),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppIconButton(icon: const Icon(Icons.favorite_rounded, color: AppColors.orange500, size: 20), filled: false, onPressed: () {}),
              AppIconButton(icon: const Icon(Icons.share_rounded, color: Colors.white, size: 20), filled: true, onPressed: () {}),
              AppIconButton(icon: const Icon(Icons.bookmark_rounded, color: AppColors.orange500, size: 20), filled: false, onPressed: () {}),
              AppIconButton(icon: const Icon(Icons.send_rounded, color: Colors.white, size: 18), filled: true, onPressed: () {}),
            ],
          ),

          _section('Floating Action Buttons', isDark),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppFAB(icon: const Icon(Icons.add_rounded, color: Colors.white)),
              AppFAB(
                icon: const Icon(Icons.add_rounded, color: Colors.white),
                label: 'New Post',
              ),
            ],
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