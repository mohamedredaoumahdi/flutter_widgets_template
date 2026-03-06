import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  SEARCH BAR
// ─────────────────────────────────────────────
class AppSearchBar extends StatefulWidget {
  final TextEditingController? controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;
  final VoidCallback? onTap;
  final bool readOnly;

  const AppSearchBar({
    super.key,
    this.controller,
    this.hint = 'Search...',
    this.onChanged,
    this.onFilterTap,
    this.onTap,
    this.readOnly = false,
  });

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final FocusNode _focus = FocusNode();
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() => _focused = _focus.hasFocus));
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 52,
        decoration: BoxDecoration(
          color: isDark
              ? (_focused ? AppColors.dark600 : AppColors.dark700)
              : (_focused ? Colors.white : AppColors.light200),
          borderRadius: AppRadius.full,
          border: Border.all(
            color: _focused
                ? AppColors.orange500
                : isDark
                    ? AppColors.dark400
                    : AppColors.light400,
            width: _focused ? 2 : 1,
          ),
          boxShadow: _focused
              ? [
                  BoxShadow(
                    color: AppColors.orange500.withOpacity(0.12),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
              : [],
        ),
        child: Row(children: [
          const SizedBox(width: 16),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: Icon(
              Icons.search_rounded,
              key: ValueKey(_focused),
              size: 20,
              color: _focused
                  ? AppColors.orange500
                  : isDark
                      ? AppColors.textDarkHint
                      : AppColors.textLightHint,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focus,
              onChanged: widget.onChanged,
              readOnly: widget.readOnly,
              style: TextStyle(
                fontFamily: 'Sora',
                fontSize: 15,
                color: isDark
                    ? AppColors.textDarkPrimary
                    : AppColors.textLightPrimary,
              ),
              cursorColor: AppColors.orange500,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 14,
                  color: isDark
                      ? AppColors.textDarkHint
                      : AppColors.textLightHint,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (widget.onFilterTap != null) ...[
            Container(
              width: 1,
              height: 22,
              color: isDark ? AppColors.dark400 : AppColors.light400,
            ),
            GestureDetector(
              onTap: widget.onFilterTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.orange500.withOpacity(0.12),
                    borderRadius: AppRadius.sm,
                  ),
                  child: const Icon(Icons.tune_rounded,
                      color: AppColors.orange500, size: 16),
                ),
              ),
            ),
          ] else
            const SizedBox(width: 16),
        ]),
      ),
    );
  }
}
