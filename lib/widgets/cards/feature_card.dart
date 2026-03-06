import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  FEATURE CARD  (decorative circles + animated CTA)
// ─────────────────────────────────────────────
class FeatureCard extends StatefulWidget {
  final String title;
  final String description;
  final Widget? icon;
  final VoidCallback? onTap;
  final String? actionLabel;
  final Gradient? gradient;
  final String? tag;

  const FeatureCard({
    super.key,
    required this.title,
    required this.description,
    this.icon,
    this.onTap,
    this.actionLabel,
    this.gradient,
    this.tag,
  });

  @override
  State<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<FeatureCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _arrow;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 130));
    _scale = Tween(begin: 1.0, end: 0.97).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _arrow = Tween(begin: 0.0, end: 5.0).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) { _ctrl.reverse(); widget.onTap?.call(); },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          decoration: BoxDecoration(
            gradient: widget.gradient ?? AppGradients.orangePrimary,
            borderRadius: AppRadius.xl,
            boxShadow: AppShadows.orangeGlow,
          ),
          child: Stack(children: [
            // Decorative background circles
            Positioned(right: -20, top: -20,
              child: Container(width: 110, height: 110,
                decoration: BoxDecoration(shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.07)))),
            Positioned(right: 40, bottom: -35,
              child: Container(width: 80, height: 80,
                decoration: BoxDecoration(shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.05)))),
            // Content
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    if (widget.icon != null) ...[
                      Container(
                        width: 50, height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: AppRadius.md,
                          border: Border.all(color: Colors.white.withOpacity(0.15)),
                        ),
                        child: Center(
                          child: IconTheme(
                            data: const IconThemeData(color: Colors.white, size: 24),
                            child: widget.icon!,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                    ],
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        if (widget.tag != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: AppRadius.full,
                            ),
                            child: Text(widget.tag!,
                                style: const TextStyle(
                                  fontFamily: 'Sora', fontSize: 10,
                                  fontWeight: FontWeight.w700, color: Colors.white,
                                )),
                          ),
                          const SizedBox(height: 8),
                        ],
                        Text(widget.title,
                            style: const TextStyle(
                              fontFamily: 'Sora', fontSize: 18,
                              fontWeight: FontWeight.w700, color: Colors.white, height: 1.2,
                            )),
                      ]),
                    ),
                  ]),
                  const SizedBox(height: AppSpacing.sm),
                  Text(widget.description,
                      style: TextStyle(
                        fontFamily: 'Sora', fontSize: 13,
                        color: Colors.white.withOpacity(0.82), height: 1.55,
                      )),
                  if (widget.actionLabel != null) ...[
                    const SizedBox(height: AppSpacing.md),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: AppRadius.full,
                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                      ),
                      child: AnimatedBuilder(
                        animation: _arrow,
                        builder: (_, __) => Row(mainAxisSize: MainAxisSize.min, children: [
                          Text(widget.actionLabel!,
                              style: const TextStyle(
                                fontFamily: 'Sora', fontSize: 13,
                                fontWeight: FontWeight.w600, color: Colors.white,
                              )),
                          const SizedBox(width: 6),
                          Transform.translate(
                            offset: Offset(_arrow.value, 0),
                            child: const Icon(Icons.arrow_forward_rounded,
                                color: Colors.white, size: 15),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
