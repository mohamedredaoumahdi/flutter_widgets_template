import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class TypographyScreen extends StatelessWidget {
  const TypographyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppTopBar(title: 'Typography & Colors', showBack: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [

          _section('Type Scale', isDark),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Display Large — 32px Bold', style: AppTextStyles.displayLarge(isDark)),
                const SizedBox(height: AppSpacing.sm),
                Text('Display Medium — 26px Bold', style: AppTextStyles.displayMedium(isDark)),
                const SizedBox(height: AppSpacing.sm),
                Divider(color: isDark ? AppColors.dark400 : AppColors.light400, thickness: 0.5),
                const SizedBox(height: AppSpacing.sm),
                Text('Heading 1 — 22px Bold', style: AppTextStyles.h1(isDark)),
                const SizedBox(height: AppSpacing.xs),
                Text('Heading 2 — 18px SemiBold', style: AppTextStyles.h2(isDark)),
                const SizedBox(height: AppSpacing.xs),
                Text('Heading 3 — 16px SemiBold', style: AppTextStyles.h3(isDark)),
                const SizedBox(height: AppSpacing.sm),
                Divider(color: isDark ? AppColors.dark400 : AppColors.light400, thickness: 0.5),
                const SizedBox(height: AppSpacing.sm),
                Text('Body Large — 15px Regular', style: AppTextStyles.bodyLarge(isDark)),
                const SizedBox(height: AppSpacing.xs),
                Text('Body Medium — 14px Regular', style: AppTextStyles.bodyMedium(isDark)),
                const SizedBox(height: AppSpacing.xs),
                Text('Body Small — 12px Regular', style: AppTextStyles.bodySmall(isDark)),
                const SizedBox(height: AppSpacing.sm),
                Divider(color: isDark ? AppColors.dark400 : AppColors.light400, thickness: 0.5),
                const SizedBox(height: AppSpacing.sm),
                Text('LABEL LARGE — 14px SemiBold', style: AppTextStyles.labelLarge(isDark)),
                const SizedBox(height: AppSpacing.xs),
                Text('LABEL SMALL — 11px Medium', style: AppTextStyles.labelSmall(isDark)),
              ],
            ),
          ),

          _section('Brand Colors', isDark),
          _colorRow([
            _swatch('50', AppColors.orange50, dark: true),
            _swatch('100', AppColors.orange100, dark: true),
            _swatch('200', AppColors.orange200, dark: true),
            _swatch('300', AppColors.orange300),
            _swatch('400', AppColors.orange400),
            _swatch('500 ★', AppColors.orange500),
            _swatch('600', AppColors.orange600),
            _swatch('700', AppColors.orange700),
            _swatch('800', AppColors.orange800),
            _swatch('900', AppColors.orange900),
          ]),

          _section('Status Colors', isDark),
          Row(children: [
            Expanded(child: _bigSwatch('Success', AppColors.success)),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: _bigSwatch('Warning', AppColors.warning)),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: _bigSwatch('Error', AppColors.error)),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: _bigSwatch('Info', AppColors.info)),
          ]),

          _section('Dark Surfaces', isDark),
          _colorRow([
            _swatch('900', AppColors.dark900),
            _swatch('800', AppColors.dark800),
            _swatch('700', AppColors.dark700),
            _swatch('600', AppColors.dark600),
            _swatch('500', AppColors.dark500),
            _swatch('400', AppColors.dark400),
            _swatch('300', AppColors.dark300),
          ]),

          _section('Gradients', isDark),
          Container(
            height: 64,
            decoration: const BoxDecoration(
              gradient: AppGradients.orangePrimary,
              borderRadius: AppRadius.lg,
            ),
            child: Center(child: Text('Orange Primary', style: const TextStyle(
                fontFamily: 'Sora', fontWeight: FontWeight.w600, color: Colors.white))),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            height: 64,
            decoration: const BoxDecoration(
              gradient: AppGradients.orangeSoft,
              borderRadius: AppRadius.lg,
            ),
            child: Center(child: Text('Orange Soft', style: const TextStyle(
                fontFamily: 'Sora', fontWeight: FontWeight.w600, color: Colors.white))),
          ),

          _section('Border Radius Scale', isDark),
          Wrap(spacing: AppSpacing.sm, runSpacing: AppSpacing.sm, children: [
            _radiusSwatch('SM — 8', const BorderRadius.all(Radius.circular(8)), isDark),
            _radiusSwatch('MD — 12', const BorderRadius.all(Radius.circular(12)), isDark),
            _radiusSwatch('LG — 16', const BorderRadius.all(Radius.circular(16)), isDark),
            _radiusSwatch('XL — 24', const BorderRadius.all(Radius.circular(24)), isDark),
            _radiusSwatch('Full', AppRadius.full, isDark),
          ]),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _colorRow(List<Widget> swatches) => Row(
    children: swatches.map((s) => Expanded(child: s)).toList(),
  );

  Widget _swatch(String label, Color color, {bool dark = false}) {
    return Container(
      height: 48,
      color: color,
      child: Center(child: Text(label, style: TextStyle(
        fontFamily: 'Sora', fontSize: 8, fontWeight: FontWeight.w600,
        color: dark ? Colors.black54 : Colors.white70),
        textAlign: TextAlign.center),
      ),
    );
  }

  Widget _bigSwatch(String label, Color color) => Container(
    height: 72,
    decoration: BoxDecoration(color: color, borderRadius: AppRadius.md),
    child: Center(child: Text(label, style: const TextStyle(
        fontFamily: 'Sora', fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white))),
  );

  Widget _radiusSwatch(String label, BorderRadius radius, bool isDark) => Container(
    width: 80, height: 56,
    decoration: BoxDecoration(
      color: AppColors.orange500.withOpacity(0.15),
      border: Border.all(color: AppColors.orange500, width: 1.5),
      borderRadius: radius,
    ),
    child: Center(child: Text(label, style: TextStyle(
        fontFamily: 'Sora', fontSize: 10, fontWeight: FontWeight.w600,
        color: AppColors.orange500), textAlign: TextAlign.center)),
  );
}

Widget _section(String title, bool isDark) => Padding(
  padding: const EdgeInsets.only(top: AppSpacing.lg, bottom: AppSpacing.sm),
  child: Row(children: [
    Container(width: 3, height: 16, decoration: BoxDecoration(gradient: AppGradients.orangePrimary, borderRadius: AppRadius.full)),
    const SizedBox(width: 8),
    Text(title, style: AppTextStyles.h3(isDark)),
  ]),
);