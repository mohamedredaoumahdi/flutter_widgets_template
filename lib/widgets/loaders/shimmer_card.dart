import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'shimmer_loader.dart';

// Card shimmer placeholder
class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: isDark ? AppColors.dark700 : AppColors.light100,
        borderRadius: AppRadius.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            ShimmerLoader(
                width: 44, height: 44,
                borderRadius: BorderRadius.circular(22)),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLoader(width: 120, height: 12,
                    borderRadius: BorderRadius.circular(6)),
                const SizedBox(height: 6),
                ShimmerLoader(width: 80, height: 10,
                    borderRadius: BorderRadius.circular(5)),
              ],
            ),
          ]),
          const SizedBox(height: AppSpacing.md),
          ShimmerLoader(width: double.infinity, height: 12,
              borderRadius: BorderRadius.circular(6)),
          const SizedBox(height: 8),
          ShimmerLoader(width: 200, height: 12,
              borderRadius: BorderRadius.circular(6)),
          const SizedBox(height: 8),
          ShimmerLoader(width: 140, height: 12,
              borderRadius: BorderRadius.circular(6)),
        ],
      ),
    );
  }
}
