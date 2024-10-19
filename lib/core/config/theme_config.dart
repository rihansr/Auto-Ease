import 'package:flutter/material.dart';
import '../shared/colors.dart';
import '../shared/constants.dart';

ThemeData theming(ThemeMode mode) {
  ColorPalette colorPalette;
  switch (mode) {
    case ThemeMode.light:
      colorPalette = ColorPalette.light();
      break;
    case ThemeMode.dark:
    default:
      colorPalette = ColorPalette.dark();
  }

  return ThemeData(
    fontFamily: kFontFamily,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: mode == ThemeMode.light ? Brightness.light : Brightness.dark,
      primary: colorPalette.primary,
      onPrimary: colorPalette.onPrimary,
      secondary: colorPalette.secondary,
      onSecondary: colorPalette.onSecondary,
      tertiary: colorPalette.tertiary,
      onTertiary: colorPalette.onTertiary,
      surface: colorPalette.surface,
      onSurface: colorPalette.onSurface,
      error: colorPalette.error,
      onError: colorPalette.onError,
      shadow: colorPalette.shadow,
      outline: colorPalette.outline,
      surfaceTint: Colors.transparent,
    ),
    highlightColor: colorPalette.highlight,
    dialogBackgroundColor: colorPalette.scaffold,
    canvasColor: colorPalette.surface,
    primaryColor: colorPalette.primary,
    dividerColor: colorPalette.divider,
    brightness: mode == ThemeMode.light ? Brightness.light : Brightness.dark,
    shadowColor: colorPalette.shadow,
    scaffoldBackgroundColor: colorPalette.scaffold,
    cardColor: colorPalette.card,
    hintColor: colorPalette.hint,
    disabledColor: colorPalette.disable,
    iconTheme: IconThemeData(
      color: colorPalette.icon,
      size: 24,
    ),
    appBarTheme: const AppBarTheme().copyWith(
      color: Colors.transparent,
      shadowColor: colorPalette.shadow,
      foregroundColor: colorPalette.icon,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: colorPalette.icon, size: 24),
      actionsIconTheme: IconThemeData(color: colorPalette.subtitle, size: 24),
      toolbarHeight: 88,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
        letterSpacing: 0.15,
        color: colorPalette.headline,
      ),
    ),
    switchTheme: SwitchThemeData(
      trackOutlineWidth: WidgetStateProperty.all(0),
      thumbColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) => Colors.white,
      ),
      trackColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) => states.contains(WidgetState.selected)
            ? colorPalette.primary
            : colorPalette.outline,
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) => colorPalette.primary,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      fillColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) => states.contains(WidgetState.selected)
            ? colorPalette.primary
            : Colors.transparent,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      side: WidgetStateBorderSide.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? BorderSide(
                color: colorPalette.primary,
                strokeAlign: 0,
                width: 5,
              )
            : BorderSide(
                color: colorPalette.outline,
                strokeAlign: 4,
                width: 1,
              ),
      ),
    ),
    cardTheme: const CardTheme().copyWith(
      clipBehavior: Clip.antiAlias,
      color: colorPalette.card,
      surfaceTintColor: Colors.transparent,
      shadowColor: colorPalette.shadow,
      elevation: 2,
      margin: const EdgeInsets.all(2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: const ButtonStyle().copyWith(
        overlayColor: const WidgetStatePropertyAll<Color>(
          Colors.transparent,
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 15,
            height: 1,
            color: colorPalette.primary,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ),
    dividerTheme: const DividerThemeData().copyWith(
      color: colorPalette.divider,
      thickness: 1,
    ),
    snackBarTheme: const SnackBarThemeData().copyWith(
      backgroundColor: colorPalette.surface,
      contentTextStyle: TextStyle(
        fontSize: 14,
        height: 1.43,
        color: colorPalette.paragraph,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
      elevation: 2,
      actionTextColor: colorPalette.paragraph,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
      type: BottomNavigationBarType.fixed,
      backgroundColor: colorPalette.surface,
      elevation: 4,
      selectedIconTheme: IconThemeData(color: colorPalette.onPrimary, size: 24),
      unselectedIconTheme: IconThemeData(color: colorPalette.icon, size: 24),
      unselectedItemColor: colorPalette.paragraph,
      selectedItemColor: colorPalette.headline,
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        height: 1.33,
        fontWeight: FontWeight.w600,
        color: colorPalette.paragraph,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        height: 1.33,
        fontWeight: FontWeight.w500,
        color: colorPalette.paragraph,
      ),
    ),
    textTheme: const TextTheme().copyWith(
      headlineMedium: TextStyle(
        fontSize: 28,
        height: 1.29,
        letterSpacing: -0.17,
        color: colorPalette.headline,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        height: 1.33,
        color: colorPalette.headline,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        height: 1.27,
        color: colorPalette.headline,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        height: 1.5,
        letterSpacing: 0.15,
        color: colorPalette.headline,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        height: 1.43,
        letterSpacing: 0.1,
        color: colorPalette.subtitle,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontSize: 12,
        height: 1.5,
        color: colorPalette.paragraph,
        fontWeight: FontWeight.w400,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        height: 1.33,
        letterSpacing: 0.5,
        color: colorPalette.subtitle,
        fontWeight: FontWeight.w400,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        height: 1.8,
        color: colorPalette.subtitle,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        height: 1.5,
        letterSpacing: 0.5,
        color: colorPalette.paragraph,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        height: 1.43,
        color: colorPalette.paragraph,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        height: 1.33,
        color: colorPalette.paragraph,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}