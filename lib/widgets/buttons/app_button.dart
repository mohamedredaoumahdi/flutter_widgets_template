import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  APP BUTTON — Primary, Secondary, Ghost, Icon
// ─────────────────────────────────────────────

enum AppButtonVariant { primary, secondary, ghost, danger }
enum AppButtonSize { small, medium, large }

class AppButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool isLoading;
  final bool fullWidth;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.fullWidth = false,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 100));
    _scaleAnim = Tween(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDisabled = widget.onPressed == null || widget.isLoading;

    final (height, hPad, fontSize) = switch (widget.size) {
      AppButtonSize.small  => (38.0, 16.0, 13.0),
      AppButtonSize.medium => (48.0, 24.0, 14.0),
      AppButtonSize.large  => (56.0, 32.0, 16.0),
    };

    return ScaleTransition(
      scale: _scaleAnim,
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) { _controller.reverse(); widget.onPressed?.call(); },
        onTapCancel: () => _controller.reverse(),
        child: AnimatedOpacity(
          opacity: isDisabled ? 0.5 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: _buildButtonBody(
            isDark, isDisabled, height, hPad, fontSize),
        ),
      ),
    );
  }

  Widget _buildButtonBody(bool isDark, bool disabled,
      double height, double hPad, double fontSize) {
    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.isLoading) ...[
          SizedBox(
            width: 18, height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: _foregroundColor(isDark),
            ),
          ),
          const SizedBox(width: 8),
        ] else if (widget.leadingIcon != null) ...[
          widget.leadingIcon!,
          const SizedBox(width: 8),
        ],
        Text(
          widget.label,
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: _foregroundColor(isDark),
            letterSpacing: 0.2,
          ),
        ),
        if (widget.trailingIcon != null) ...[
          const SizedBox(width: 8),
          widget.trailingIcon!,
        ],
      ],
    );

    final container = Container(
      height: height,
      width: widget.fullWidth ? double.infinity : null,
      padding: EdgeInsets.symmetric(horizontal: hPad),
      decoration: _decoration(isDark),
      child: Center(child: content),
    );

    return widget.fullWidth ? container : IntrinsicWidth(child: container);
  }

  BoxDecoration _decoration(bool isDark) {
    return switch (widget.variant) {
      AppButtonVariant.primary => BoxDecoration(
        gradient: AppGradients.orangePrimary,
        borderRadius: AppRadius.full,
        boxShadow: widget.onPressed != null ? AppShadows.orangeGlow : [],
      ),
      AppButtonVariant.secondary => BoxDecoration(
        color: Colors.transparent,
        borderRadius: AppRadius.full,
        border: Border.all(color: AppColors.orange500, width: 1.5),
      ),
      AppButtonVariant.ghost => BoxDecoration(
        color: isDark
            ? AppColors.orange500.withOpacity(0.12)
            : AppColors.orange500.withOpacity(0.08),
        borderRadius: AppRadius.full,
      ),
      AppButtonVariant.danger => BoxDecoration(
        color: AppColors.error,
        borderRadius: AppRadius.full,
        boxShadow: [
          BoxShadow(
            color: AppColors.error.withOpacity(0.3),
            blurRadius: 16, offset: const Offset(0, 6)),
        ],
      ),
    };
  }

  Color _foregroundColor(bool isDark) {
    return switch (widget.variant) {
      AppButtonVariant.primary   => Colors.white,
      AppButtonVariant.secondary => AppColors.orange500,
      AppButtonVariant.ghost     => AppColors.orange500,
      AppButtonVariant.danger    => Colors.white,
    };
  }
}
