import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/app_theme.dart';

/// Clean bordered input with label, focus/error border, icon color, error/helper/char count.
class AppTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final String? helper;
  final String? errorText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool showCharCount;

  const AppTextField({
    super.key,
    required this.label,
    this.hint,
    this.helper,
    this.errorText,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.inputFormatters,
    this.focusNode,
    this.showCharCount = false,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isFocused = false;
  bool _obscure = true;
  late FocusNode _focus;
  int _charCount = 0;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
    _focus = widget.focusNode ?? FocusNode();
    _focus.addListener(() => setState(() => _isFocused = _focus.hasFocus));
    _charCount = widget.controller?.text.length ?? 0;
    widget.controller?.addListener(() {
      if (mounted) setState(() => _charCount = widget.controller!.text.length);
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasError = widget.errorText != null;

    final Color borderColor;
    if (hasError) {
      borderColor = AppColors.error;
    } else if (_isFocused) {
      borderColor = AppColors.orange500;
    } else {
      borderColor = isDark ? AppColors.dark400 : AppColors.light400;
    }

    final Color iconColor = _isFocused
        ? AppColors.orange500
        : isDark
            ? AppColors.textDarkHint
            : AppColors.textLightHint;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 7),
          child: Text(
            widget.label,
            style: TextStyle(
              fontFamily: 'Sora',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: hasError
                  ? AppColors.error
                  : _isFocused
                      ? AppColors.orange500
                      : isDark
                          ? AppColors.textDarkPrimary
                          : AppColors.textLightPrimary,
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: widget.maxLines == 1 ? 52 : null,
          decoration: BoxDecoration(
            color: isDark
                ? (_isFocused ? AppColors.dark600 : AppColors.dark700)
                : (_isFocused
                    ? Colors.white
                    : AppColors.light200),
            borderRadius: AppRadius.md,
            border: Border.all(
              color: borderColor,
              width: _isFocused || hasError ? 2 : 1,
            ),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: (hasError ? AppColors.error : AppColors.orange500)
                          .withOpacity(0.12),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.prefixIcon != null) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: IconTheme(
                    data: IconThemeData(color: iconColor, size: 20),
                    child: widget.prefixIcon!,
                  ),
                ),
              ],
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focus,
                  obscureText: widget.obscureText ? _obscure : false,
                  keyboardType: widget.keyboardType,
                  maxLines: widget.obscureText ? 1 : widget.maxLines,
                  maxLength: widget.maxLength,
                  onChanged: (v) {
                    setState(() => _charCount = v.length);
                    widget.onChanged?.call(v);
                  },
                  onTap: widget.onTap,
                  readOnly: widget.readOnly,
                  inputFormatters: widget.inputFormatters,
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: isDark
                        ? AppColors.textDarkPrimary
                        : AppColors.textLightPrimary,
                  ),
                  cursorColor: AppColors.orange500,
                  cursorRadius: const Radius.circular(2),
                  cursorWidth: 2,
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    hintStyle: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isDark
                          ? AppColors.textDarkHint
                          : AppColors.textLightHint,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    counterText: '',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: widget.prefixIcon != null ? 10 : 14,
                      vertical: widget.maxLines != 1 ? 14 : 0,
                    ),
                    isDense: true,
                  ),
                ),
              ),
              if (widget.obscureText)
                GestureDetector(
                  onTap: () => setState(() => _obscure = !_obscure),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: Icon(
                      _obscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: iconColor,
                      size: 20,
                    ),
                  ),
                )
              else if (widget.suffixIcon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: IconTheme(
                    data: IconThemeData(color: iconColor, size: 20),
                    child: widget.suffixIcon!,
                  ),
                )
              else
                const SizedBox(width: 14),
            ],
          ),
        ),
        if (hasError || widget.helper != null ||
            (widget.showCharCount && widget.maxLength != null)) ...[
          const SizedBox(height: 5),
          Row(children: [
            if (hasError)
              Expanded(
                child: Row(children: [
                  const Icon(Icons.error_outline_rounded,
                      size: 13, color: AppColors.error),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      widget.errorText!,
                      style: const TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ]),
              )
            else if (widget.helper != null)
              Expanded(
                child: Row(children: [
                  Icon(Icons.info_outline_rounded,
                      size: 13,
                      color: isDark
                          ? AppColors.textDarkHint
                          : AppColors.textLightHint),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      widget.helper!,
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 11,
                        color: isDark
                            ? AppColors.textDarkHint
                            : AppColors.textLightHint,
                      ),
                    ),
                  ),
                ]),
              )
            else
              const Spacer(),
            if (widget.showCharCount && widget.maxLength != null)
              Text(
                '$_charCount / ${widget.maxLength}',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: _charCount > widget.maxLength! * 0.9
                      ? AppColors.warning
                      : isDark
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
