import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../shared/constants.dart';

class Button<T> extends StatelessWidget {
  final T? shape;
  final Color? background;
  final Color borderTint;
  final double borderSize;
  final double radius;
  final TextStyle? fontStyle;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final String? label;
  final double contentSpacing;
  final double? minFontSize;
  final double? fontSize;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Axis direction;
  final bool disable;
  final bool loading;
  final WrapAlignment horizontalAlignment;
  final WrapAlignment verticalAlignment;
  final WrapCrossAlignment wrapCrossAlignment;
  final Function()? onPressed;

  const Button({
    super.key,
    this.shape,
    this.label,
    this.background,
    this.borderTint = Colors.transparent,
    this.radius = 2,
    this.fontStyle,
    this.fontColor,
    this.fontSize,
    this.leading,
    this.trailing,
    this.fontWeight,
    this.margin = const EdgeInsets.symmetric(vertical: 8),
    this.padding = const EdgeInsets.all(12),
    this.contentSpacing = 18,
    this.minFontSize,
    this.borderSize = 0,
    this.direction = Axis.horizontal,
    this.disable = false,
    this.loading = false,
    this.horizontalAlignment = WrapAlignment.center,
    this.verticalAlignment = WrapAlignment.center,
    this.wrapCrossAlignment = WrapCrossAlignment.center,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    TextStyle labelStyle =
        (this.fontStyle ?? theme.textTheme.titleMedium)!.copyWith(
      color: disable
          ? null
          : fontColor ?? this.fontStyle?.color ?? theme.colorScheme.onPrimary,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );

    Color? fillColor =
        disable ? theme.disabledColor : this.background ?? theme.primaryColor;

    return Padding(
      padding: margin,
      child: InkWell(
        onTap: () {
          if (!(disable || loading)) {
            HapticFeedback.selectionClick();
            onPressed?.call();
          }
        },
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          padding: padding,
          alignment: Alignment.center,
          decoration: shape is ShapeBorder
              ? ShapeDecoration(
                  shape: shape as ShapeBorder,
                  color: fillColor,
                )
              : BoxDecoration(
                  shape: shape as BoxShape? ?? BoxShape.rectangle,
                  borderRadius: shape == BoxShape.circle
                      ? null
                      : BorderRadius.circular(radius),
                  border: Border.all(color: borderTint, width: borderSize),
                  color: fillColor,
                ),
          child: AnimatedCrossFade(
            firstChild: Text(
              key: const Key('default_state'),
              label!,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: labelStyle,
            ),
            secondChild: SizedBox(
              key: const Key('loading_state'),
              height: labelStyle.fontSize! * 1.5,
              child: CupertinoActivityIndicator(
                color: labelStyle.color,
              ),
            ),
            crossFadeState:
                loading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: kDefaultDuration,
          ),
        ),
      ),
    );
  }
}
