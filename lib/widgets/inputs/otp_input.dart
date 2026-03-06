import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  OTP / PIN INPUT
// ─────────────────────────────────────────────
class OtpInput extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final bool obscure;

  const OtpInput({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
    this.obscure = false,
  });

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _nodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _nodes = List.generate(widget.length, (_) => FocusNode());
    for (var f in _nodes) {
      f.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) c.dispose();
    for (var f in _nodes) f.dispose();
    super.dispose();
  }

  String get _value => _controllers.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.length, (i) {
        final focused = _nodes[i].hasFocus;
        final filled = _controllers[i].text.isNotEmpty;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 46,
          height: 56,
          decoration: BoxDecoration(
            color: isDark
                ? (focused ? AppColors.dark600 : AppColors.dark700)
                : (focused ? Colors.white : AppColors.light200),
            borderRadius: AppRadius.md,
            border: Border.all(
              color: filled
                  ? AppColors.orange500
                  : focused
                      ? AppColors.orange500
                      : isDark
                          ? AppColors.dark400
                          : AppColors.light400,
              width: focused || filled ? 2 : 1,
            ),
            boxShadow: focused
                ? [
                    BoxShadow(
                      color: AppColors.orange500.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ]
                : [],
          ),
          child: Center(
            child: TextField(
              controller: _controllers[i],
              focusNode: _nodes[i],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              obscureText: widget.obscure,
              maxLength: 1,
              style: TextStyle(
                fontFamily: 'Sora',
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: isDark
                    ? AppColors.textDarkPrimary
                    : AppColors.textLightPrimary,
              ),
              cursorColor: AppColors.orange500,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: '',
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (v) {
                setState(() {});
                if (v.isNotEmpty && i < widget.length - 1) {
                  _nodes[i + 1].requestFocus();
                } else if (v.isEmpty && i > 0) {
                  _nodes[i - 1].requestFocus();
                }
                widget.onChanged?.call(_value);
                if (_value.length == widget.length) {
                  widget.onCompleted?.call(_value);
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
