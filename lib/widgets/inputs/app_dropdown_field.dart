import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  DROPDOWN FIELD
// ─────────────────────────────────────────────
class AppDropdownField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? hint;
  final Widget? prefixIcon;

  const AppDropdownField({
    super.key,
    required this.label,
    this.value,
    required this.items,
    this.onChanged,
    this.hint,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasValue = value != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 7),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Sora',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.textDarkPrimary
                  : AppColors.textLightPrimary,
            ),
          ),
        ),
        Container(
          height: 52,
          decoration: BoxDecoration(
            color: isDark ? AppColors.dark700 : AppColors.light200,
            borderRadius: AppRadius.md,
            border: Border.all(
              color: hasValue
                  ? AppColors.orange500.withOpacity(0.6)
                  : isDark
                      ? AppColors.dark400
                      : AppColors.light400,
              width: hasValue ? 1.5 : 1,
            ),
          ),
          padding: EdgeInsets.only(
            left: prefixIcon != null ? 12 : 14,
            right: 8,
          ),
          child: Row(children: [
            if (prefixIcon != null) ...[
              IconTheme(
                data: IconThemeData(
                  color: hasValue
                      ? AppColors.orange500
                      : isDark
                          ? AppColors.textDarkHint
                          : AppColors.textLightHint,
                  size: 18,
                ),
                child: prefixIcon!,
              ),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<T>(
                  value: value,
                  items: items,
                  onChanged: onChanged,
                  hint: hint != null
                      ? Text(
                          hint!,
                          style: TextStyle(
                            fontFamily: 'Sora',
                            fontSize: 14,
                            color: isDark
                                ? AppColors.textDarkHint
                                : AppColors.textLightHint,
                          ),
                        )
                      : null,
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: isDark
                        ? AppColors.textDarkPrimary
                        : AppColors.textLightPrimary,
                  ),
                  dropdownColor:
                      isDark ? AppColors.dark700 : AppColors.light100,
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: hasValue
                        ? AppColors.orange500
                        : isDark
                            ? AppColors.textDarkHint
                            : AppColors.textLightHint,
                  ),
                  isExpanded: true,
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
