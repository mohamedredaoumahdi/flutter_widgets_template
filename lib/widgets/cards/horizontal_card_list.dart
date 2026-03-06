import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  HORIZONTAL QUICK-STAT CARD STRIP
// ─────────────────────────────────────────────
class QuickStatCard {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const QuickStatCard({required this.label, required this.value, required this.icon, required this.color});
}

class HorizontalCardList extends StatelessWidget {
  final List<QuickStatCard> cards;
  const HorizontalCardList({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: cards.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (ctx, i) {
          final isDark = Theme.of(ctx).brightness == Brightness.dark;
          final card = cards[i];
          return Container(
            width: 136,
            decoration: BoxDecoration(
              color: card.color.withOpacity(0.1),
              borderRadius: AppRadius.lg,
              border: Border.all(color: card.color.withOpacity(0.25)),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(
                    color: card.color.withOpacity(0.15),
                    borderRadius: AppRadius.sm,
                  ),
                  child: Icon(card.icon, color: card.color, size: 16),
                ),
                const Spacer(),
                Text(
                  card.value,
                  style: TextStyle(
                    fontFamily: 'Sora', fontSize: 16,
                    fontWeight: FontWeight.w800, color: card.color,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  card.label,
                  style: AppTextStyles.bodySmall(isDark),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
