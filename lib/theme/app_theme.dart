import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the Journal Hub application.
class AppTheme {
  AppTheme._();

  // Primary colors
  static const Color primary = Color(0xFF4F46E5);       // Indigo-600
  static const Color primaryLight = Color(0xFF818CF8);  // Indigo-400
  static const Color primaryDark = Color(0xFF3730A3);   // Indigo-800

  // Neutral colors
  static const Color background = Color(0xFFF8FAFC);    // Slate-50
  static const Color surface = Color(0xFFFFFFFF);       // White
  static const Color border = Color(0xFFE2E8F0);        // Slate-200
  static const Color textPrimary = Color(0xFF0F172A);   // Slate-900
  static const Color textSecondary = Color(0xFF475569); // Slate-600
  static const Color textTertiary = Color(0xFF94A3B8);  // Slate-400

  // Semantic colors
  static const Color success = Color(0xFF10B981);       // Emerald-500
  static const Color warning = Color(0xFFF59E0B);       // Amber-500
  static const Color error = Color(0xFFF43F5E);         // Rose-500
  static const Color info = Color(0xFF0EA5E9);          // Sky-500

  // Journal category colors
  static const Color meditation = Color(0xFF8B5CF6);    // Violet-500
  static const Color food = Color(0xFF34D399);          // Emerald-400
  static const Color travel = Color(0xFF06B6D4);        // Cyan-500
  static const Color work = Color(0xFF3B82F6);          // Blue-500
  static const Color emotional = Color(0xFFD946EF);     // Fuchsia-500
  static const Color ideas = Color(0xFFFBBF24);         // Amber-400

  // Dark theme colors
  static const Color backgroundDark = Color(0xFF1E293B); // Slate-800
  static const Color surfaceDark = Color(0xFF334155);    // Slate-700
  static const Color borderDark = Color(0xFF475569);     // Slate-600
  static const Color textPrimaryDark = Color(0xFFF8FAFC); // Slate-50
  static const Color textSecondaryDark = Color(0xFFCBD5E1); // Slate-300
  static const Color textTertiaryDark = Color(0xFF94A3B8); // Slate-400

  // Shadow colors
  static const Color shadowLight = Color(0x1F000000);
  static const Color shadowDark = Color(0x1FFFFFFF);

  /// Light theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: Colors.white,
      primaryContainer: primaryLight,
      onPrimaryContainer: primaryDark,
      secondary: info,
      onSecondary: Colors.white,
      secondaryContainer: info.withAlpha(51),
      onSecondaryContainer: info,
      tertiary: meditation,
      onTertiary: Colors.white,
      tertiaryContainer: meditation.withAlpha(51),
      onTertiaryContainer: meditation,
      error: error,
      onError: Colors.white,
      errorContainer: error.withAlpha(51),
      onErrorContainer: error,
      surface: surface,
      onSurface: textPrimary,
      surfaceContainerHighest: border.withAlpha(77),
      onSurfaceVariant: textSecondary,
      outline: border,
      outlineVariant: border.withAlpha(128),
      shadow: shadowLight,
      scrim: Colors.black.withAlpha(77),
      inverseSurface: textPrimary,
      onInverseSurface: surface,
      inversePrimary: primaryLight,
    ),
    scaffoldBackgroundColor: background,
    cardColor: surface,
    dividerColor: border,
    
    // Typography
    textTheme: _buildTextTheme(isLight: true),
    
    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: surface,
      foregroundColor: textPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      iconTheme: IconThemeData(color: textPrimary),
    ),
    
    // Card Theme
    cardTheme: CardTheme(
      color: surface,
      elevation: 2,
      shadowColor: shadowLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    
    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surface,
      selectedItemColor: primary,
      unselectedItemColor: textTertiary,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
    
    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    
    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: BorderSide(color: primary, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    
    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surface,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: border, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: border, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: error, width: 2),
      ),
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textSecondary,
      ),
      hintStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textTertiary,
      ),
      helperStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textSecondary,
      ),
      errorStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: error,
      ),
      prefixIconColor: textSecondary,
      suffixIconColor: textSecondary,
    ),
    
    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary;
        }
        return null;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      side: BorderSide(color: textSecondary, width: 1.5),
    ),
    
    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary;
        }
        return Colors.white;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary.withAlpha(128);
        }
        return textTertiary.withAlpha(77);
      }),
    ),
    
    // Radio Theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary;
        }
        return textSecondary;
      }),
    ),
    
    // Progress Indicator Theme
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primary,
      circularTrackColor: primaryLight.withAlpha(51),
      linearTrackColor: primaryLight.withAlpha(51),
    ),
    
    // Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: primary,
      inactiveTrackColor: primaryLight.withAlpha(77),
      thumbColor: primary,
      overlayColor: primary.withAlpha(51),
      valueIndicatorColor: primary,
      valueIndicatorTextStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
    
    // Tab Bar Theme
    tabBarTheme: TabBarTheme(
      labelColor: primary,
      unselectedLabelColor: textSecondary,
      indicatorColor: primary,
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    
    // Tooltip Theme
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: textPrimary.withAlpha(230),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
    
    // Snackbar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: textPrimary,
      contentTextStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      actionTextColor: primaryLight,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    
    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: border.withAlpha(77),
      disabledColor: border.withAlpha(26),
      selectedColor: primaryLight.withAlpha(51),
      secondarySelectedColor: primaryLight.withAlpha(51),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      secondaryLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: primary,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    
    // Dialog Theme
    dialogTheme: DialogTheme(
      backgroundColor: surface,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      contentTextStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textSecondary,
      ),
    ),
  );

  /// Dark theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primaryLight,
      onPrimary: Colors.black,
      primaryContainer: primary,
      onPrimaryContainer: Colors.white,
      secondary: info,
      onSecondary: Colors.black,
      secondaryContainer: info.withAlpha(51),
      onSecondaryContainer: info,
      tertiary: meditation,
      onTertiary: Colors.black,
      tertiaryContainer: meditation.withAlpha(51),
      onTertiaryContainer: meditation,
      error: error,
      onError: Colors.black,
      errorContainer: error.withAlpha(51),
      onErrorContainer: error,
      surface: surfaceDark,
      onSurface: textPrimaryDark,
      surfaceContainerHighest: borderDark.withAlpha(77),
      onSurfaceVariant: textSecondaryDark,
      outline: borderDark,
      outlineVariant: borderDark.withAlpha(128),
      shadow: shadowDark,
      scrim: Colors.black.withAlpha(128),
      inverseSurface: textPrimaryDark,
      onInverseSurface: surfaceDark,
      inversePrimary: primary,
    ),
    scaffoldBackgroundColor: backgroundDark,
    cardColor: surfaceDark,
    dividerColor: borderDark,
    
    // Typography
    textTheme: _buildTextTheme(isLight: false),
    
    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceDark,
      foregroundColor: textPrimaryDark,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimaryDark,
      ),
      iconTheme: IconThemeData(color: textPrimaryDark),
    ),
    
    // Card Theme
    cardTheme: CardTheme(
      color: surfaceDark,
      elevation: 2,
      shadowColor: shadowDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    
    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceDark,
      selectedItemColor: primaryLight,
      unselectedItemColor: textTertiaryDark,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
    
    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLight,
      foregroundColor: Colors.black,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    
    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: BorderSide(color: primaryLight, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    
    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceDark,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderDark, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderDark, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryLight, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: error, width: 2),
      ),
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textSecondaryDark,
      ),
      hintStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textTertiaryDark,
      ),
      helperStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textSecondaryDark,
      ),
      errorStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: error,
      ),
      prefixIconColor: textSecondaryDark,
      suffixIconColor: textSecondaryDark,
    ),
    
    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight;
        }
        return null;
      }),
      checkColor: WidgetStateProperty.all(Colors.black),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      side: BorderSide(color: textSecondaryDark, width: 1.5),
    ),
    
    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight;
        }
        return Colors.white;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight.withAlpha(128);
        }
        return textTertiaryDark.withAlpha(77);
      }),
    ),
    
    // Radio Theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight;
        }
        return textSecondaryDark;
      }),
    ),
    
    // Progress Indicator Theme
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primaryLight,
      circularTrackColor: primary.withAlpha(51),
      linearTrackColor: primary.withAlpha(51),
    ),
    
    // Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: primaryLight,
      inactiveTrackColor: primary.withAlpha(77),
      thumbColor: primaryLight,
      overlayColor: primaryLight.withAlpha(51),
      valueIndicatorColor: primaryLight,
      valueIndicatorTextStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    ),
    
    // Tab Bar Theme
    tabBarTheme: TabBarTheme(
      labelColor: primaryLight,
      unselectedLabelColor: textSecondaryDark,
      indicatorColor: primaryLight,
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    
    // Tooltip Theme
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: textPrimaryDark.withAlpha(230),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: surfaceDark,
      ),
    ),
    
    // Snackbar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: surfaceDark,
      contentTextStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textPrimaryDark,
      ),
      actionTextColor: primaryLight,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    
    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: borderDark.withAlpha(77),
      disabledColor: borderDark.withAlpha(26),
      selectedColor: primary.withAlpha(51),
      secondarySelectedColor: primary.withAlpha(51),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textPrimaryDark,
      ),
      secondaryLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: primaryLight,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    
    // Dialog Theme
    dialogTheme: DialogTheme(
      backgroundColor: surfaceDark,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimaryDark,
      ),
      contentTextStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textSecondaryDark,
      ),
    ),
  );

  /// Helper method to build text theme based on brightness
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textPrimaryColor = isLight ? textPrimary : textPrimaryDark;
    final Color textSecondaryColor = isLight ? textSecondary : textSecondaryDark;
    final Color textTertiaryColor = isLight ? textTertiary : textTertiaryDark;
    
    // Using Inter for display and body text, DM Serif Display for accent text
    return TextTheme(
      // Display styles
      displayLarge: GoogleFonts.inter(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: textPrimaryColor,
        letterSpacing: -0.5,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
        letterSpacing: -0.25,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
      ),
      
      // Body styles
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textPrimaryColor,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textSecondaryColor,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textTertiaryColor,
      ),
      
      // Label styles
      labelLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textPrimaryColor,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textSecondaryColor,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textTertiaryColor,
      ),
      
      // Headline styles (for section headers)
      headlineLarge: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textPrimaryColor,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
      ),
      
      // Title styles
      titleLarge: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
      ),
    );
  }

  /// Get accent text style for inspirational quotes and highlights
  static TextStyle getAccentTextStyle({bool isLight = true}) {
    final Color textColor = isLight ? textPrimary : textPrimaryDark;
    
    return GoogleFonts.dmSerifDisplay(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: textColor,
      letterSpacing: 0.15,
    );
  }

  /// Get category color based on journal type
  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'meditation':
        return meditation;
      case 'food':
        return food;
      case 'travel':
        return travel;
      case 'work':
        return work;
      case 'emotional':
        return emotional;
      case 'ideas':
        return ideas;
      default:
        return primary;
    }
  }

  /// Theme mode helper
  static ThemeMode getThemeMode(String mode) {
    switch (mode) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }
}