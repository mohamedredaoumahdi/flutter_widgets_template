import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  AVATAR  (gradient ring + pulse online dot)
// ─────────────────────────────────────────────
enum AvatarSize { xs, sm, md, lg, xl }
enum AvatarStatus { online, offline, away, busy, none }

class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final AvatarSize size;
  final AvatarStatus status;
  final VoidCallback? onTap;
  final Color? borderColor;
  final bool gradientBorder;

  const AppAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = AvatarSize.md,
    this.status = AvatarStatus.none,
    this.onTap,
    this.borderColor,
    this.gradientBorder = false,
    // legacy compat
  }) ;

  // ignore: unused_element
  const AppAvatar._legacy({
    super.key,
    this.imageUrl,
    this.name,
    this.size = AvatarSize.md,
    this.status = AvatarStatus.none,
    this.onTap,
    this.borderColor,
    this.gradientBorder = false,
  });

  double get _dim => switch (size) {
    AvatarSize.xs => 28, AvatarSize.sm => 36,
    AvatarSize.md => 48, AvatarSize.lg => 64, AvatarSize.xl => 84,
  };

  double get _fontSize => switch (size) {
    AvatarSize.xs => 10, AvatarSize.sm => 13,
    AvatarSize.md => 16, AvatarSize.lg => 22, AvatarSize.xl => 28,
  };

  double get _dotSize => switch (size) {
    AvatarSize.xs || AvatarSize.sm => 8,
    AvatarSize.md => 11,
    AvatarSize.lg || AvatarSize.xl => 14,
  };

  Color get _statusColor => switch (status) {
    AvatarStatus.online  => AppColors.success,
    AvatarStatus.away    => AppColors.warning,
    AvatarStatus.busy    => AppColors.error,
    AvatarStatus.offline => AppColors.textDarkHint,
    AvatarStatus.none    => Colors.transparent,
  };

  String _initials() {
    if (name == null || name!.isEmpty) return '?';
    final parts = name!.trim().split(' ');
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final showStatus = status != AvatarStatus.none;

    Widget avatar = Container(
      width: _dim, height: _dim,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: imageUrl == null ? AppGradients.orangePrimary : null,
        color: imageUrl != null ? Colors.transparent : null,
        image: imageUrl != null
            ? DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.cover)
            : null,
        boxShadow: [
          BoxShadow(
            color: AppColors.orange500.withOpacity(0.18),
            blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: imageUrl == null
          ? Center(
              child: Text(_initials(),
                  style: TextStyle(
                    fontFamily: 'Sora', fontSize: _fontSize,
                    fontWeight: FontWeight.w700, color: Colors.white,
                  )))
          : null,
    );

    // Gradient ring wrapper
    if (gradientBorder) {
      avatar = Container(
        width: _dim + 4, height: _dim + 4,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppGradients.orangePrimary,
        ),
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          padding: const EdgeInsets.all(2),
          child: avatar,
        ),
      );
    } else if (borderColor != null) {
      avatar = Container(
        width: _dim + 6, height: _dim + 6,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: borderColor,
        ),
        padding: const EdgeInsets.all(2.5),
        child: ClipOval(child: avatar),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          if (showStatus)
            Positioned(
              right: gradientBorder || borderColor != null ? 3 : 0,
              bottom: gradientBorder || borderColor != null ? 3 : 0,
              child: _PulsingDot(
                size: _dotSize,
                color: _statusColor,
                pulse: status == AvatarStatus.online,
                scaffoldColor: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
        ],
      ),
    );
  }
}

// Pulsing online dot
class _PulsingDot extends StatefulWidget {
  final double size;
  final Color color;
  final bool pulse;
  final Color scaffoldColor;
  const _PulsingDot({required this.size, required this.color, required this.pulse, required this.scaffoldColor});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));
    _anim = Tween(begin: 0.8, end: 1.4).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    if (widget.pulse) _ctrl.repeat(reverse: true);
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      if (widget.pulse)
        AnimatedBuilder(
          animation: _anim,
          builder: (_, __) => Container(
            width: widget.size * _anim.value,
            height: widget.size * _anim.value,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color.withOpacity(0.3),
            ),
          ),
        ),
      Container(
        width: widget.size, height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color,
          border: Border.all(color: widget.scaffoldColor, width: 1.5),
        ),
      ),
    ]);
  }
}
