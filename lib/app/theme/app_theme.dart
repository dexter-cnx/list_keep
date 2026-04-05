import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() {
    return _buildTheme(
      brightness: Brightness.light,
      scheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF2D4B43),
        onPrimary: Color(0xFFFCF9F4),
        primaryContainer: Color(0xFFD9E4DD),
        onPrimaryContainer: Color(0xFF132823),
        secondary: Color(0xFF16342D),
        onSecondary: Color(0xFFFCF9F4),
        secondaryContainer: Color(0xFFDEE8E3),
        onSecondaryContainer: Color(0xFF16342D),
        tertiary: Color(0xFFE48A6E),
        onTertiary: Color(0xFFFFFFFF),
        tertiaryContainer: Color(0xFFF7D9CE),
        onTertiaryContainer: Color(0xFF592616),
        error: Color(0xFFB42318),
        onError: Color(0xFFFFFFFF),
        errorContainer: Color(0xFFFEE4E2),
        onErrorContainer: Color(0xFF7A271A),
        surface: Color(0xFFFCF9F4),
        onSurface: Color(0xFF1A1A1A),
        onSurfaceVariant: Color(0xFF666666),
        outline: Color(0xFFB9B0A4),
        outlineVariant: Color(0xFFD6CEC2),
        shadow: Color(0xFF000000),
        scrim: Color(0xFF000000),
        inverseSurface: Color(0xFF26312D),
        onInverseSurface: Color(0xFFF6F3EE),
        inversePrimary: Color(0xFFC4D1CA),
        surfaceTint: Color(0xFF2D4B43),
        surfaceContainerLowest: Color(0xFFFFFEFC),
        surfaceContainerLow: Color(0xFFF7F3ED),
        surfaceContainer: Color(0xFFF1ECE4),
        surfaceContainerHigh: Color(0xFFE7DFD5),
        surfaceContainerHighest: Color(0xFFDDD3C7),
      ),
    );
  }

  static ThemeData dark() {
    return _buildTheme(
      brightness: Brightness.dark,
      scheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFCFBEF5),
        onPrimary: Color(0xFF1A1426),
        primaryContainer: Color(0xFF392F50),
        onPrimaryContainer: Color(0xFFF1E9FF),
        secondary: Color(0xFF8EA6FF),
        onSecondary: Color(0xFF101424),
        secondaryContainer: Color(0xFF1F2B42),
        onSecondaryContainer: Color(0xFFD8E2FF),
        tertiary: Color(0xFFE7A98F),
        onTertiary: Color(0xFF2A130A),
        tertiaryContainer: Color(0xFF4B2A1D),
        onTertiaryContainer: Color(0xFFFFE4DA),
        error: Color(0xFFFDA29B),
        onError: Color(0xFF3B0A07),
        errorContainer: Color(0xFF7E241D),
        onErrorContainer: Color(0xFFFEE4E2),
        surface: Color(0xFF0D1117),
        onSurface: Color(0xFFF3F4F6),
        onSurfaceVariant: Color(0xFFC6C6CB),
        outline: Color(0xFF667085),
        outlineVariant: Color(0xFF344055),
        shadow: Color(0xFF000000),
        scrim: Color(0xFF000000),
        inverseSurface: Color(0xFFE9EEF6),
        onInverseSurface: Color(0xFF111827),
        inversePrimary: Color(0xFF2D4B43),
        surfaceTint: Color(0xFFCFBEF5),
        surfaceContainerLowest: Color(0xFF111724),
        surfaceContainerLow: Color(0xFF151C2A),
        surfaceContainer: Color(0xFF1A2230),
        surfaceContainerHigh: Color(0xFF202A3A),
        surfaceContainerHighest: Color(0xFF273144),
      ),
    );
  }

  static ThemeData _buildTheme({
    required Brightness brightness,
    required ColorScheme scheme,
  }) {
    final baseTextTheme = brightness == Brightness.light
        ? Typography.material2021().black
        : Typography.material2021().white;
    final textTheme = baseTextTheme.apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: Colors.transparent,
      canvasColor: Colors.transparent,
      textTheme: textTheme.copyWith(
        displaySmall: textTheme.displaySmall?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.6,
          height: 1.08,
        ),
        headlineSmall: textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.35,
          height: 1.18,
        ),
        titleLarge: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
        titleMedium: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.1,
        ),
        bodyLarge: textTheme.bodyLarge?.copyWith(height: 1.5),
        bodyMedium: textTheme.bodyMedium?.copyWith(height: 1.45),
        labelLarge: textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.02,
        ),
        labelSmall: textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.08,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: scheme.onSurface,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
        iconTheme: IconThemeData(color: scheme.onSurface),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark
            ? scheme.surfaceContainerLow.withValues(alpha: 0.92)
            : scheme.surfaceContainerLowest,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
        labelStyle: textTheme.labelLarge?.copyWith(
          color: scheme.onSurfaceVariant,
          fontWeight: FontWeight.w700,
        ),
        helperStyle: textTheme.bodySmall?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: scheme.primary, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: scheme.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: scheme.error, width: 1.8),
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surfaceContainerLowest.withValues(
          alpha: isDark ? 0.88 : 1,
        ),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.12)
                : scheme.outlineVariant.withValues(alpha: 0.75),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: isDark
            ? scheme.surfaceContainerHigh.withValues(alpha: 0.95)
            : scheme.surfaceContainerHigh,
        selectedColor: isDark
            ? scheme.primary.withValues(alpha: 0.22)
            : scheme.secondaryContainer,
        disabledColor: scheme.surfaceContainerHigh.withValues(alpha: 0.7),
        labelStyle: textTheme.labelLarge?.copyWith(
          color: scheme.onSurface,
          fontWeight: FontWeight.w700,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        side: BorderSide(
          color: isDark
              ? Colors.white.withValues(alpha: 0.12)
              : scheme.outlineVariant.withValues(alpha: 0.55),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          side: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.18)
                : scheme.outlineVariant.withValues(alpha: 0.9),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: scheme.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.12)
                : scheme.outlineVariant.withValues(alpha: 0.45),
          ),
        ),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.surfaceContainerHighest,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      dividerTheme: DividerThemeData(
        color: isDark
            ? Colors.white.withValues(alpha: 0.12)
            : scheme.outlineVariant.withValues(alpha: 0.7),
        space: 1,
        thickness: 1,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.12)
                : scheme.outlineVariant.withValues(alpha: 0.55),
          ),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),
      visualDensity: VisualDensity.standard,
    );
  }
}
