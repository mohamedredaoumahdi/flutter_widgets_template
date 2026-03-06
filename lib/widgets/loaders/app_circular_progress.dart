import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  CIRCULAR PROGRESS
// ─────────────────────────────────────────────
class AppCircularProgress extends StatelessWidget {
  final double value; // 0.0 to 1.0
  final double size;
  final double strokeWidth;
  final Widget? child;

  const AppCircularProgress({
    super.key,
    required this.value,
    this.size = 80,
    this.strokeWidth = 6,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: size, height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size, height: size,
            child: CircularProgressIndicator(
              value: 1,
              strokeWidth: strokeWidth,
              color: isDark ? AppColors.dark500 : AppColors.light400,
            ),
          ),
          SizedBox(
            width: size, height: size,
            child: CircularProgressIndicator(
              value: value.clamp(0.0, 1.0),
              strokeWidth: strokeWidth,
              strokeCap: StrokeCap.round,
              valueColor: const AlwaysStoppedAnimation(AppColors.orange500),
            ),
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}
