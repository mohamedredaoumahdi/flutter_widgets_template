import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  BASE CARD  (press-to-scale)
// ─────────────────────────────────────────────
class AppCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool useGradient;
  final Color? color;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? shadows;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.useGradient = false,
    this.color,
    this.borderRadius,
    this.shadows,
  });

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 90));
    _scale = Tween(begin: 1.0, end: 0.975)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final br = widget.borderRadius ?? const BorderRadius.all(Radius.circular(16));

    return GestureDetector(
      onTapDown: widget.onTap != null ? (_) => _ctrl.forward() : null,
      onTapUp: widget.onTap != null ? (_) { _ctrl.reverse(); widget.onTap!(); } : null,
      onTapCancel: widget.onTap != null ? () => _ctrl.reverse() : null,
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          decoration: BoxDecoration(
            gradient: widget.useGradient ? (isDark ? AppGradients.darkCard : null) : null,
            color: !widget.useGradient
                ? (widget.color ?? (isDark ? AppColors.dark700 : AppColors.light100))
                : null,
            borderRadius: br,
            boxShadow: widget.shadows ?? (isDark ? AppShadows.cardDark : AppShadows.cardLight),
            border: Border.all(
              color: isDark ? AppColors.dark400.withOpacity(0.6) : AppColors.light400,
              width: 0.5,
            ),
          ),
          padding: widget.padding ?? const EdgeInsets.all(AppSpacing.md),
          child: widget.child,
        ),
      ),
    );
  }
}
