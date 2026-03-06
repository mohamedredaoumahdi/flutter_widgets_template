import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  CHIP / TAG (selectable)
// ─────────────────────────────────────────────
class AppChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final Widget? leadingIcon;
  final bool removable;
  final VoidCallback? onRemove;

  const AppChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
    this.leadingIcon,
    this.removable = false,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          gradient: selected ? AppGradients.orangePrimary : null,
          color: selected ? null : (isDark ? AppColors.dark600 : AppColors.light300),
          borderRadius: AppRadius.full,
          border: Border.all(
            color: selected ? Colors.transparent
                : isDark ? AppColors.dark400 : AppColors.light400,
          ),
          boxShadow: selected ? AppShadows.orangeGlow : null,
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (leadingIcon != null) ...[
            IconTheme(
              data: IconThemeData(
                size: 14,
                color: selected ? Colors.white
                    : isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
              ),
              child: leadingIcon!,
            ),
            const SizedBox(width: 5),
          ],
          Text(label,
              style: TextStyle(
                fontFamily: 'Sora', fontSize: 12, fontWeight: FontWeight.w500,
                color: selected ? Colors.white
                    : isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
              )),
          if (removable) ...[
            const SizedBox(width: 5),
            GestureDetector(
              onTap: onRemove,
              child: Icon(
                Icons.close_rounded, size: 13,
                color: selected ? Colors.white
                    : isDark ? AppColors.textDarkHint : AppColors.textLightHint,
              ),
            ),
          ],
        ]),
      ),
    );
  }
}
