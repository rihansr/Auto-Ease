import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ColorPalette {
  Color primary;
  Color onPrimary;
  Color onPrimaryContainer;
  Color secondary;
  Color onSecondary;
  Color tertiary;
  Color onTertiary;
  Color highlight;
  Color surface;
  Color onSurface;
  Color scaffold;
  Color card;
  Color shadow;
  Color icon;
  Color headline;
  Color paragraph;
  Color subtitle;
  Color hint;
  Color outline;
  Color divider;
  Color disable;
  Color error;
  Color onError;

  ColorPalette({
    required this.primary,
    required this.onPrimary,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.tertiary,
    required this.onTertiary,
    required this.highlight,
    required this.surface,
    required this.onSurface,
    required this.scaffold,
    required this.card,
    required this.shadow,
    required this.icon,
    required this.headline,
    required this.paragraph,
    required this.subtitle,
    required this.hint,
    required this.outline,
    required this.divider,
    required this.disable,
    required this.error,
    required this.onError,
  });

  factory ColorPalette.light() => ColorPalette(
        primary: const Color(0xFF0e63f4),
        onPrimary: const Color(0xFFFFFFFF),
        onPrimaryContainer: const Color(0xFFE7EFFE),
        secondary: const Color(0xFF54c1fb),
        onSecondary: const Color(0xFF0D5ADE),
        tertiary: const Color(0xFFff5670),
        onTertiary: const Color(0xFFffeef1),
        surface: const Color(0xFFFFFFFF),
        onSurface: const Color(0xFF342E5E),
        highlight: const Color(0xFFFFFFFF),
        scaffold: const Color(0xFFFAFAFB),
        card: const Color(0xFFFFFFFF),
        shadow: const Color(0x1A101828),
        icon: const Color(0xFF342E5E),
        headline: const Color(0xFF07003B),
        paragraph: const Color(0xFF342E5E),
        subtitle: const Color(0xFF6A6689),
        hint: const Color(0xFF797595),
        outline: const Color(0xFFC1BFCE),
        divider: const Color(0xFFEBEBEF),
        disable: const Color(0xFFEBEBEF),
        error: const Color(0xFFF04438),
        onError: const Color(0xFFFFFFFF),
      );

  factory ColorPalette.dark() => ColorPalette(
        primary: const Color(0xFF0e63f4),
        onPrimary: const Color(0xFFFFFFFF),
        onPrimaryContainer: const Color(0xFF342E5E),
        secondary: const Color(0xFF54c1fb),
        onSecondary: const Color(0xFF0D5ADE),
        tertiary: const Color(0xFFff5670),
        onTertiary: const Color(0xFFffeef1),
        surface: const Color(0xFF07003B),
        onSurface: const Color(0xFFC1BFCE),
        highlight: const Color(0xFF1A1A1A),
        scaffold: const Color(0xFF130D45),
        card: const Color(0xFF07003B),
        shadow: const Color(0x1A101828),
        icon: const Color(0xFFB0BEC5),
        headline: const Color(0xFFFFFFFF),
        paragraph: const Color(0xFFC1BFCE),
        subtitle: const Color(0xFFB2B0C2),
        hint: const Color(0xFF797595),
        outline: const Color(0xFF6A6689),
        divider: const Color(0xFF342E5E),
        disable: const Color(0xFF342E5E),
        error: const Color(0xFFF04438),
        onError: const Color(0xFFFFFFFF),
      );
}
