import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class LoadersScreen extends StatefulWidget {
  const LoadersScreen({super.key});
  @override
  State<LoadersScreen> createState() => _LoadersScreenState();
}

class _LoadersScreenState extends State<LoadersScreen> {
  double _progress1 = 0.72;
  double _progress2 = 0.35;
  double _progress3 = 0.9;
  bool _showOverlay = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        Scaffold(
          appBar: AppTopBar(title: 'Loaders & Progress', showBack: true),
          body: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [

              _section('Shimmer Skeleton Loaders', isDark),
              const ShimmerCard(),
              const SizedBox(height: AppSpacing.sm),
              // Row of shimmer items
              Row(children: [
                Expanded(child: AppCard(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    ShimmerLoader(width: double.infinity, height: 100, borderRadius: AppRadius.md),
                    const SizedBox(height: 10),
                    ShimmerLoader(width: 120, height: 12, borderRadius: BorderRadius.circular(6)),
                    const SizedBox(height: 6),
                    ShimmerLoader(width: 80, height: 10, borderRadius: BorderRadius.circular(5)),
                  ]),
                )),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: AppCard(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    ShimmerLoader(width: double.infinity, height: 100, borderRadius: AppRadius.md),
                    const SizedBox(height: 10),
                    ShimmerLoader(width: 100, height: 12, borderRadius: BorderRadius.circular(6)),
                    const SizedBox(height: 6),
                    ShimmerLoader(width: 60, height: 10, borderRadius: BorderRadius.circular(5)),
                  ]),
                )),
              ]),

              _section('Progress Bars', isDark),
              AppCard(
                child: Column(children: [
                  AppProgressBar(value: _progress1, showLabel: true, label: 'Profile Completion'),
                  const SizedBox(height: AppSpacing.md),
                  AppProgressBar(value: _progress2, showLabel: true, label: 'Storage Used'),
                  const SizedBox(height: AppSpacing.md),
                  AppProgressBar(value: _progress3, showLabel: true, label: 'Monthly Goal'),
                  const SizedBox(height: AppSpacing.md),
                  Row(children: [
                    Expanded(child: AppButton(
                      label: '−10%',
                      variant: AppButtonVariant.ghost,
                      size: AppButtonSize.small,
                      onPressed: () => setState(() => _progress1 = (_progress1 - 0.1).clamp(0, 1)),
                    )),
                    const SizedBox(width: 8),
                    Expanded(child: AppButton(
                      label: '+10%',
                      size: AppButtonSize.small,
                      onPressed: () => setState(() => _progress1 = (_progress1 + 0.1).clamp(0, 1)),
                    )),
                  ]),
                ]),
              ),

              _section('Circular Progress', isDark),
              AppCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      AppCircularProgress(value: _progress1, size: 88, strokeWidth: 7,
                        child: Text('${(_progress1 * 100).toInt()}%',
                            style: TextStyle(fontFamily: 'Sora', fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.orange500))),
                      const SizedBox(height: 8),
                      Text('Completion', style: AppTextStyles.bodySmall(isDark)),
                    ]),
                    Column(children: [
                      AppCircularProgress(value: _progress2, size: 72, strokeWidth: 6,
                        child: const Icon(Icons.storage_rounded, color: AppColors.orange500, size: 22)),
                      const SizedBox(height: 8),
                      Text('Storage', style: AppTextStyles.bodySmall(isDark)),
                    ]),
                    Column(children: [
                      AppCircularProgress(value: _progress3, size: 60, strokeWidth: 5,
                        child: const Icon(Icons.bolt_rounded, color: AppColors.orange500, size: 18)),
                      const SizedBox(height: 8),
                      Text('Goal', style: AppTextStyles.bodySmall(isDark)),
                    ]),
                  ],
                ),
              ),

              _section('Loading Overlay', isDark),
              AppButton(
                label: 'Show Loading Overlay',
                fullWidth: true,
                variant: AppButtonVariant.secondary,
                onPressed: () async {
                  setState(() => _showOverlay = true);
                  await Future.delayed(const Duration(seconds: 2));
                  if (mounted) setState(() => _showOverlay = false);
                },
              ),

              _section('Empty States', isDark),
              AppEmptyState(
                title: 'No Messages Yet',
                description: 'Start a conversation to see your messages appear here.',
                illustration: Container(width: 90, height: 90,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.orange500.withOpacity(0.1)),
                  child: const Icon(Icons.chat_bubble_outline_rounded, size: 44, color: AppColors.orange500)),
                actionLabel: 'Start chatting',
                onAction: () {},
              ),
              const SizedBox(height: AppSpacing.md),
              AppEmptyState(
                title: 'Nothing Found',
                description: 'Try adjusting your search or filters.',
                illustration: Container(width: 80, height: 80,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.info.withOpacity(0.1)),
                  child: const Icon(Icons.search_off_rounded, size: 40, color: AppColors.info)),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
        if (_showOverlay)
          const AppLoadingOverlay(message: 'Processing your request...'),
      ],
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