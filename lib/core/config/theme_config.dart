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
    useMaterial3: false,
    colorScheme: ColorScheme(
      brightness: mode == ThemeMode.light ? Brightness.light : Brightness.dark,
      primary: colorPalette.primary,
      onPrimary: colorPalette.onPrimary,
      onPrimaryContainer: colorPalette.onPrimaryContainer,
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
      toolbarHeight: 88.0,
      color: Colors.transparent,
      shadowColor: colorPalette.shadow,
      foregroundColor: colorPalette.icon,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: colorPalette.icon, size: 24),
      actionsIconTheme: IconThemeData(color: colorPalette.subtitle, size: 24),
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
        letterSpacing: 0.15,
        color: colorPalette.headline,
      ),
    ),
    tabBarTheme: const TabBarTheme().copyWith(
      labelColor: colorPalette.headline,
      unselectedLabelColor: colorPalette.paragraph,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
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
    listTileTheme: const ListTileThemeData().copyWith(
      titleTextStyle: TextStyle(
        fontSize: 16,
        height: 1.5,
        letterSpacing: 0.15,
        color: colorPalette.headline,
        fontWeight: FontWeight.w400,
      ),
      subtitleTextStyle: TextStyle(
        fontSize: 14,
        height: 1.43,
        color: colorPalette.hint,
        fontWeight: FontWeight.w400,
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) => colorPalette.primary,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      visualDensity: const VisualDensity(horizontal: -4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      fillColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) => states.contains(WidgetState.selected)
            ? colorPalette.primary
            : Colors.transparent,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      side: WidgetStateBorderSide.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? BorderSide(color: colorPalette.primary, strokeAlign: 1, width: 1)
            : BorderSide(color: colorPalette.outline, strokeAlign: 1, width: 1),
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
      backgroundColor: Colors.transparent,
      elevation: 0,
      unselectedItemColor: colorPalette.paragraph,
      selectedItemColor: colorPalette.headline,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        height: 1.75,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        height: 1.75,
        fontWeight: FontWeight.w400,
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
