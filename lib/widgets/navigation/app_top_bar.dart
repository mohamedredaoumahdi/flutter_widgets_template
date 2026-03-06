import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  CUSTOM APP BAR
// ─────────────────────────────────────────────
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBack;
  final bool transparent;
  final double elevation;

  const AppTopBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.showBack = true,
    this.transparent = false,
    this.elevation = 0,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: transparent
          ? Colors.transparent
          : isDark ? AppColors.dark900 : AppColors.light100,
      elevation: elevation,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: showBack
          ? GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                margin: const EdgeInsets.only(left: AppSpacing.md),
                width: 40, height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark ? AppColors.dark700 : AppColors.light300,
                ),
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: isDark
                      ? AppColors.textDarkPrimary
                      : AppColors.textLightPrimary,
                  size: 20,
                ),
              ),
            )
          : leading,
      title: titleWidget ??
          (title != null
              ? Text(title!,
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? AppColors.textDarkPrimary
                        : AppColors.textLightPrimary,
                  ))
              : null),
      actions: actions != null
          ? [
              ...actions!,
              const SizedBox(width: AppSpacing.sm),
            ]
          : null,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 0.5,
          color: transparent
              ? Colors.transparent
              : isDark
                  ? AppColors.dark400.withOpacity(0.5)
                  : AppColors.light400,
        ),
      ),
    );
  }
}
