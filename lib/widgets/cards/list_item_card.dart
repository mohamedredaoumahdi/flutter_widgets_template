import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  LIST ITEM CARD  (accent strip + tag + press)
// ─────────────────────────────────────────────
class ListItemCard extends StatefulWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? accentColor;
  final String? tag;
  final Color? tagColor;

  const ListItemCard({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.accentColor,
    this.tag,
    this.tagColor,
  });

  @override
  State<ListItemCard> createState() => _ListItemCardState();
}

class _ListItemCardState extends State<ListItemCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 80));
    _scale = Tween(begin: 1.0, end: 0.98)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: widget.onTap != null ? (_) => _ctrl.forward() : null,
      onTapUp: widget.onTap != null ? (_) { _ctrl.reverse(); widget.onTap!(); } : null,
      onTapCancel: widget.onTap != null ? () => _ctrl.reverse() : null,
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.dark700 : AppColors.light100,
            borderRadius: AppRadius.lg,
            border: Border.all(
              color: isDark ? AppColors.dark400.withOpacity(0.6) : AppColors.light400,
              width: 0.5,
            ),
            boxShadow: isDark ? AppShadows.cardDark : AppShadows.cardLight,
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 12),
          child: Row(children: [
            if (widget.accentColor != null) ...[
              Container(
                width: 3, height: 40,
                decoration: BoxDecoration(
                  color: widget.accentColor,
                  borderRadius: AppRadius.full,
                ),
              ),
              const SizedBox(width: 10),
            ],
            if (widget.leading != null) ...[
              widget.leading!,
              const SizedBox(width: AppSpacing.md),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(children: [
                    Expanded(child: Text(widget.title, style: AppTextStyles.h3(isDark))),
                    if (widget.tag != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: (widget.tagColor ?? AppColors.orange500).withOpacity(0.12),
                          borderRadius: AppRadius.full,
                        ),
                        child: Text(widget.tag!,
                            style: TextStyle(
                              fontFamily: 'Sora', fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: widget.tagColor ?? AppColors.orange500,
                            )),
                      ),
                    ],
                  ]),
                  if (widget.subtitle != null) ...[
                    const SizedBox(height: 3),
                    Text(widget.subtitle!,
                        style: AppTextStyles.bodyMedium(isDark),
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            if (widget.trailing != null)
              widget.trailing!
            else if (widget.onTap != null)
              Container(
                width: 28, height: 28,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.dark500 : AppColors.light300,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: isDark ? AppColors.textDarkHint : AppColors.textLightHint),
              ),
          ]),
        ),
      ),
    );
  }
}
