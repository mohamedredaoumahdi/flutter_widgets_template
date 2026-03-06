import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  APP COLOR PALETTE
// ─────────────────────────────────────────────
class AppColors {
  // Orange brand palette
  static const orange50  = Color(0xFFFFF3E0);
  static const orange100 = Color(0xFFFFE0B2);
  static const orange200 = Color(0xFFFFCC80);
  static const orange300 = Color(0xFFFFB74D);
  static const orange400 = Color(0xFFFFA726);
  static const orange500 = Color(0xFFFF9800); // primary
  static const orange600 = Color(0xFFFB8C00);
  static const orange700 = Color(0xFFF57C00);
  static const orange800 = Color(0xFFE65100);
  static const orange900 = Color(0xFFBF360C);

  // Gradient
  static const gradientStart = Color(0xFFFF9800);
  static const gradientEnd   = Color(0xFFFF5722);

  // Dark theme surfaces
  static const dark900 = Color(0xFF0D0D0D);
  static const dark800 = Color(0xFF141414);
  static const dark700 = Color(0xFF1C1C1C);
  static const dark600 = Color(0xFF242424);
  static const dark500 = Color(0xFF2E2E2E);
  static const dark400 = Color(0xFF3A3A3A);
  static const dark300 = Color(0xFF4A4A4A);

  // Light theme surfaces
  static const light100 = Color(0xFFFFFFFF);
  static const light200 = Color(0xFFF9F9F9);
  static const light300 = Color(0xFFF2F2F2);
  static const light400 = Color(0xFFE8E8E8);
  static const light500 = Color(0xFFD4D4D4);

  // Status
  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFFB300);
  static const error   = Color(0xFFEF5350);
  static const info    = Color(0xFF29B6F6);

  // Text
  static const textDarkPrimary   = Color(0xFFF5F5F5);
  static const textDarkSecondary = Color(0xFF9E9E9E);
  static const textDarkHint      = Color(0xFF616161);
  static const textLightPrimary   = Color(0xFF1A1A1A);
  static const textLightSecondary = Color(0xFF757575);
  static const textLightHint      = Color(0xFFBDBDBD);
}

// ─────────────────────────────────────────────
//  GRADIENTS
// ─────────────────────────────────────────────
class AppGradients {
  static const orangePrimary = LinearGradient(
    colors: [AppColors.orange500, AppColors.gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const orangeSoft = LinearGradient(
    colors: [AppColors.orange400, AppColors.orange600],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const darkCard = LinearGradient(
    colors: [AppColors.dark700, AppColors.dark600],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const darkSurface = LinearGradient(
    colors: [AppColors.dark800, AppColors.dark700],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

// ─────────────────────────────────────────────
//  TEXT STYLES
// ─────────────────────────────────────────────
class AppTextStyles {
  static const _base = TextStyle(fontFamily: 'Sora', letterSpacing: 0.2);

  // Display
  static TextStyle displayLarge(bool isDark) => _base.copyWith(
    fontSize: 32, fontWeight: FontWeight.w700,
    color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
    letterSpacing: -0.5,
  );
  static TextStyle displayMedium(bool isDark) => _base.copyWith(
    fontSize: 26, fontWeight: FontWeight.w700,
    color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
    letterSpacing: -0.3,
  );

  // Headings
  static TextStyle h1(bool isDark) => _base.copyWith(
    fontSize: 22, fontWeight: FontWeight.w700,
    color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
  );
  static TextStyle h2(bool isDark) => _base.copyWith(
    fontSize: 18, fontWeight: FontWeight.w600,
    color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
  );
  static TextStyle h3(bool isDark) => _base.copyWith(
    fontSize: 16, fontWeight: FontWeight.w600,
    color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
  );

  // Body
  static TextStyle bodyLarge(bool isDark) => _base.copyWith(
    fontSize: 15, fontWeight: FontWeight.w400,
    color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
  );
  static TextStyle bodyMedium(bool isDark) => _base.copyWith(
    fontSize: 14, fontWeight: FontWeight.w400,
    color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
  );
  static TextStyle bodySmall(bool isDark) => _base.copyWith(
    fontSize: 12, fontWeight: FontWeight.w400,
    color: isDark ? AppColors.textDarkHint : AppColors.textLightHint,
  );

  // Labels
  static TextStyle labelLarge(bool isDark) => _base.copyWith(
    fontSize: 14, fontWeight: FontWeight.w600,
    color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
    letterSpacing: 0.3,
  );
  static TextStyle labelSmall(bool isDark) => _base.copyWith(
    fontSize: 11, fontWeight: FontWeight.w500,
    color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
    letterSpacing: 0.5,
  );
}

// ─────────────────────────────────────────────
//  SPACING & RADIUS
// ─────────────────────────────────────────────
class AppSpacing {
  static const xs  = 4.0;
  static const sm  = 8.0;
  static const md  = 16.0;
  static const lg  = 24.0;
  static const xl  = 32.0;
  static const xxl = 48.0;
}

class AppRadius {
  static const sm  = BorderRadius.all(Radius.circular(8));
  static const md  = BorderRadius.all(Radius.circular(12));
  static const lg  = BorderRadius.all(Radius.circular(16));
  static const xl  = BorderRadius.all(Radius.circular(24));
  static const full = BorderRadius.all(Radius.circular(100));
}

// ─────────────────────────────────────────────
//  SHADOWS
// ─────────────────────────────────────────────
class AppShadows {
  static List<BoxShadow> orangeGlow = [
    BoxShadow(
      color: AppColors.orange500.withOpacity(0.35),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> cardDark = [
    BoxShadow(
      color: Colors.black.withOpacity(0.4),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> cardLight = [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];
}

// ─────────────────────────────────────────────
//  THEME DATA
// ─────────────────────────────────────────────
class AppTheme {
  static ThemeData dark() => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Sora',
    scaffoldBackgroundColor: AppColors.dark900,
    colorScheme: ColorScheme.dark(
      primary: AppColors.orange500,
      primaryContainer: AppColors.orange800,
      secondary: AppColors.orange300,
      surface: AppColors.dark800,
      background: AppColors.dark900,
      onPrimary: Colors.white,
      onSecondary: AppColors.dark900,
      onSurface: AppColors.textDarkPrimary,
      onBackground: AppColors.textDarkPrimary,
    ),
    cardTheme: CardThemeData(
      color: AppColors.dark700,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.lg),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.dark900,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Sora',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.textDarkPrimary,
      ),
      iconTheme: IconThemeData(color: AppColors.textDarkPrimary),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.dark700,
      border: OutlineInputBorder(
        borderRadius: AppRadius.md,
        borderSide: const BorderSide(color: AppColors.dark400),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.md,
        borderSide: const BorderSide(color: AppColors.dark400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.md,
        borderSide: const BorderSide(color: AppColors.orange500, width: 1.5),
      ),
      hintStyle: const TextStyle(color: AppColors.textDarkHint),
    ),
    dividerTheme: const DividerThemeData(color: AppColors.dark400, thickness: 1),
  );

  static ThemeData light() => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Sora',
    scaffoldBackgroundColor: AppColors.light200,
    colorScheme: ColorScheme.light(
      primary: AppColors.orange500,
      primaryContainer: AppColors.orange100,
      secondary: AppColors.orange700,
      surface: AppColors.light100,
      background: AppColors.light200,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.textLightPrimary,
      onBackground: AppColors.textLightPrimary,
    ),
    cardTheme: CardThemeData(
      color: AppColors.light100,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.lg),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.light100,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Sora',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.textLightPrimary,
      ),
      iconTheme: IconThemeData(color: AppColors.textLightPrimary),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.light300,
      border: OutlineInputBorder(
        borderRadius: AppRadius.md,
        borderSide: const BorderSide(color: AppColors.light400),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.md,
        borderSide: const BorderSide(color: AppColors.light400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.md,
        borderSide: const BorderSide(color: AppColors.orange500, width: 1.5),
      ),
      hintStyle: const TextStyle(color: AppColors.textLightHint),
    ),
    dividerTheme: const DividerThemeData(color: AppColors.light400, thickness: 1),
  );
}