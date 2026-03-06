import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  IMAGE CARD  (media card with gradient overlay)
// ─────────────────────────────────────────────
class ImageCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? badge;
  final VoidCallback? onTap;
  final double height;
  final Color? placeholderColor;

  const ImageCard({
    super.key,
    required this.title,
    this.subtitle,
    this.badge,
    this.onTap,
    this.height = 180,
    this.placeholderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: AppRadius.xl,
        child: SizedBox(
          height: height,
          child: Stack(fit: StackFit.expand, children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    placeholderColor ?? AppColors.orange800,
                    AppColors.dark700,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Icon(Icons.image_rounded, color: Colors.white24, size: 48),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xCC000000)],
                  stops: [0.35, 1.0],
                ),
              ),
            ),
            if (badge != null) Positioned(top: 12, right: 12, child: badge!),
            Positioned(
              left: 16, right: 16, bottom: 16,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                Text(title,
                    style: const TextStyle(
                      fontFamily: 'Sora', fontSize: 16,
                      fontWeight: FontWeight.w700, color: Colors.white,
                    )),
                if (subtitle != null) ...[
                  const SizedBox(height: 3),
                  Text(subtitle!,
                      style: TextStyle(
                        fontFamily: 'Sora', fontSize: 12,
                        color: Colors.white.withOpacity(0.75),
                      )),
                ],
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
