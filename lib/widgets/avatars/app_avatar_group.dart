import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'app_avatar.dart';

// ─────────────────────────────────────────────
//  AVATAR GROUP  (stacked + labeled + tooltip)
// ─────────────────────────────────────────────
class AppAvatarGroup extends StatelessWidget {
  final List<String?> images;
  final List<String?> names;
  final int maxVisible;
  final AvatarSize size;
  final String? label; // e.g. "and 12 others"
  final bool showLabel;

  const AppAvatarGroup({
    super.key,
    required this.images,
    required this.names,
    this.maxVisible = 4,
    this.size = AvatarSize.sm,
    this.label,
    this.showLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dim = switch (size) {
      AvatarSize.xs => 28.0, AvatarSize.sm => 36.0,
      AvatarSize.md => 48.0, AvatarSize.lg => 64.0, AvatarSize.xl => 84.0,
    };
    final visible = images.take(maxVisible).toList();
    final extra = images.length - maxVisible;
    const overlap = 0.62;
    final stackWidth = dim + (visible.length - 1) * dim * overlap + (extra > 0 ? dim * overlap : 0);

    final stack = SizedBox(
      height: dim + 4,
      width: stackWidth + 4,
      child: Stack(
        children: [
          ...visible.asMap().entries.map((e) => Positioned(
            left: e.key * dim * overlap,
            top: 0,
            child: _StackedAvatar(
              imageUrl: e.value,
              name: names.length > e.key ? names[e.key] : null,
              dim: dim,
              fontSize: dim * 0.33,
              bgColor: Theme.of(context).scaffoldBackgroundColor,
            ),
          )),
          if (extra > 0)
            Positioned(
              left: visible.length * dim * overlap,
              top: 0,
              child: Container(
                width: dim + 4, height: dim + 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark ? AppColors.dark500 : AppColors.light300,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text('+$extra',
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: dim * 0.25,
                        fontWeight: FontWeight.w800,
                        color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
                      )),
                ),
              ),
            ),
        ],
      ),
    );

    if (!showLabel) return stack;

    return Row(mainAxisSize: MainAxisSize.min, children: [
      stack,
      const SizedBox(width: AppSpacing.sm),
      Text(
        label ?? (extra > 0 ? 'and $extra more' : '${images.length} members'),
        style: AppTextStyles.bodySmall(isDark),
      ),
    ]);
  }
}

class _StackedAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double dim;
  final double fontSize;
  final Color bgColor;

  const _StackedAvatar({
    required this.imageUrl,
    required this.name,
    required this.dim,
    required this.fontSize,
    required this.bgColor,
  });

  String _initials() {
    if (name == null || name!.isEmpty) return '?';
    final parts = name!.trim().split(' ');
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dim + 4, height: dim + 4,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: bgColor, width: 2),
      ),
      child: ClipOval(
        child: Container(
          decoration: BoxDecoration(
            gradient: imageUrl == null ? AppGradients.orangePrimary : null,
            image: imageUrl != null
                ? DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.cover)
                : null,
          ),
          child: imageUrl == null
              ? Center(child: Text(_initials(),
                  style: TextStyle(
                    fontFamily: 'Sora', fontSize: fontSize,
                    fontWeight: FontWeight.w700, color: Colors.white,
                  )))
              : null,
        ),
      ),
    );
  }
}
