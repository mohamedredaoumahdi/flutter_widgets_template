import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  TEXTAREA  (multi-line + progress bar)
// ─────────────────────────────────────────────
class AppTextArea extends StatefulWidget {
  final String label;
  final String? hint;
  final String? helper;
  final int maxLength;
  final int minLines;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const AppTextArea({
    super.key,
    required this.label,
    this.hint,
    this.helper,
    this.maxLength = 300,
    this.minLines = 4,
    this.controller,
    this.onChanged,
  });

  @override
  State<AppTextArea> createState() => _AppTextAreaState();
}

class _AppTextAreaState extends State<AppTextArea> {
  int _count = 0;
  bool _focused = false;
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() => _focused = _focus.hasFocus));
    _count = widget.controller?.text.length ?? 0;
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pct = (_count / widget.maxLength).clamp(0.0, 1.0);
    final countColor = pct > 0.9
        ? AppColors.error
        : pct > 0.7
            ? AppColors.warning
            : AppColors.orange500;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label row
        Padding(
          padding: const EdgeInsets.only(bottom: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _focused
                      ? AppColors.orange500
                      : isDark
                          ? AppColors.textDarkPrimary
                          : AppColors.textLightPrimary,
                ),
              ),
              Text(
                '$_count / ${widget.maxLength}',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: countColor,
                ),
              ),
            ],
          ),
        ),

        AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: isDark
                ? (_focused ? AppColors.dark600 : AppColors.dark700)
                : (_focused ? Colors.white : AppColors.light200),
            borderRadius: AppRadius.md,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: widget.controller,
                focusNode: _focus,
                minLines: widget.minLines,
                maxLines: null,
                maxLength: widget.maxLength,
                onChanged: (v) {
                  setState(() => _count = v.length);
                  widget.onChanged?.call(v);
                },
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 15,
                  color: isDark
                      ? AppColors.textDarkPrimary
                      : AppColors.textLightPrimary,
                  height: 1.5,
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
                  counterText: '',
                  contentPadding: const EdgeInsets.all(14),
                ),
              ),
              // Progress bar
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
                child: ClipRRect(
                  borderRadius: AppRadius.full,
                  child: LinearProgressIndicator(
                    value: pct,
                    minHeight: 3,
                    backgroundColor: isDark
                        ? AppColors.dark400
                        : AppColors.light400,
                    valueColor: AlwaysStoppedAnimation(countColor),
                  ),
                ),
              ),
            ],
          ),
        ),

        if (widget.helper != null) ...[
          const SizedBox(height: 5),
          Row(children: [
            Icon(Icons.info_outline_rounded,
                size: 13,
                color:
                    isDark ? AppColors.textDarkHint : AppColors.textLightHint),
            const SizedBox(width: 4),
            Text(
              widget.helper!,
              style: TextStyle(
                fontFamily: 'Sora',
                fontSize: 11,
                color: isDark
                    ? AppColors.textDarkHint
                    : AppColors.textLightHint,
              ),
            ),
          ]),
        ],
      ],
    );
  }
}
