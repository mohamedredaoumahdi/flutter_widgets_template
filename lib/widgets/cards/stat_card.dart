import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  STAT / METRIC CARD  (sparkline + trending icon)
// ─────────────────────────────────────────────
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final Widget? icon;
  final Color? accentColor;
  final double? changePercent;
  final List<double>? sparklineData;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.accentColor,
    this.changePercent,
    this.sparklineData,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = accentColor ?? AppColors.orange500;
    final isPositive = (changePercent ?? 0) >= 0;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.dark700 : AppColors.light100,
        borderRadius: AppRadius.lg,
        border: Border.all(
          color: isDark ? AppColors.dark400.withOpacity(0.6) : AppColors.light400,
          width: 0.5,
        ),
        boxShadow: isDark ? AppShadows.cardDark : AppShadows.cardLight,
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text(title, style: AppTextStyles.bodyMedium(isDark))),
              if (icon != null)
                Container(
                  width: 38, height: 38,
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.12),
                    borderRadius: AppRadius.md,
                  ),
                  child: Center(
                    child: IconTheme(
                      data: IconThemeData(color: accent, size: 19),
                      child: icon!,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Sora', fontSize: 24, fontWeight: FontWeight.w800,
              color: accent, letterSpacing: -0.5, height: 1,
            ),
          ),
          if (changePercent != null || subtitle != null) ...[
            const SizedBox(height: 8),
            Row(children: [
              if (changePercent != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: (isPositive ? AppColors.success : AppColors.error).withOpacity(0.13),
                    borderRadius: AppRadius.full,
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(
                      isPositive ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                      size: 12,
                      color: isPositive ? AppColors.success : AppColors.error,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '${changePercent!.abs().toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w700, fontFamily: 'Sora',
                        color: isPositive ? AppColors.success : AppColors.error,
                      ),
                    ),
                  ]),
                ),
                const SizedBox(width: 7),
              ],
              if (subtitle != null)
                Expanded(
                  child: Text(subtitle!,
                      style: AppTextStyles.bodySmall(isDark), overflow: TextOverflow.ellipsis),
                ),
            ]),
          ],
          if (sparklineData != null && sparklineData!.isNotEmpty) ...[
            const SizedBox(height: 12),
            _MiniSparkline(data: sparklineData!, color: accent),
          ],
        ],
      ),
    );
  }
}

class _MiniSparkline extends StatelessWidget {
  final List<double> data;
  final Color color;
  const _MiniSparkline({required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: CustomPaint(
        painter: _SparklinePainter(data: data, color: color),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<double> data;
  final Color color;
  _SparklinePainter({required this.data, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;
    final minV = data.reduce((a, b) => a < b ? a : b);
    final maxV = data.reduce((a, b) => a > b ? a : b);
    final range = (maxV - minV).abs() < 0.001 ? 1.0 : maxV - minV;

    final pts = List.generate(data.length, (i) => Offset(
      i / (data.length - 1) * size.width,
      size.height - ((data[i] - minV) / range) * size.height,
    ));

    final path = Path()..moveTo(pts[0].dx, pts[0].dy);
    final fill = Path()
      ..moveTo(pts[0].dx, size.height)
      ..lineTo(pts[0].dx, pts[0].dy);

    for (int i = 1; i < pts.length; i++) {
      final cp1 = Offset((pts[i-1].dx + pts[i].dx) / 2, pts[i-1].dy);
      final cp2 = Offset((pts[i-1].dx + pts[i].dx) / 2, pts[i].dy);
      path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, pts[i].dx, pts[i].dy);
      fill.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, pts[i].dx, pts[i].dy);
    }
    fill..lineTo(pts.last.dx, size.height)..close();

    canvas.drawPath(fill, Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter, end: Alignment.bottomCenter,
        colors: [color.withOpacity(0.25), color.withOpacity(0.0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill);

    canvas.drawPath(path, Paint()
      ..color = color..strokeWidth = 2..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round..strokeJoin = StrokeJoin.round);

    canvas.drawCircle(pts.last, 3.5, Paint()..color = color);
    canvas.drawCircle(pts.last, 3.5,
        Paint()..color = Colors.white..style = PaintingStyle.stroke..strokeWidth = 1.5);
  }

  @override
  bool shouldRepaint(_SparklinePainter old) => old.data != data;
}
