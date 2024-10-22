import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AutoSuggessionsTextField<T> extends StatelessWidget {
  const AutoSuggessionsTextField({
    super.key,
    this.title,
    this.titleStyle,
    this.fillColor,
    this.iconColor,
    this.controller,
    this.hintText,
    this.inputFormatters,
    this.validator,
    this.suffixIcon,
    this.suffix,
    this.suffixText,
    this.prefix,
    this.prefixIcon,
    this.prefixText,
    this.maxLines,
    this.keyboardType,
    this.focusNode,
    this.autoFocus = false,
    this.onFocusChange,
    this.onTap,
    this.onFieldSubmitted,
    this.onChanged,
    this.autoValidate = true,
    this.enableInteractiveSelection = true,
    this.typeable = true,
    this.enabled = true,
    this.margin = const EdgeInsets.symmetric(vertical: 8),
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    this.hintStyle,
    this.style,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    this.maxCharacters,
    this.borderRadius = 4,
    this.textInputAction,
    this.titleSpacing = 8,
    required this.suggestionsCallback,
    required this.itemBuilder,
    required this.onSuggestionSelected,
  });

  final String? title;
  final TextStyle? titleStyle;
  final Color? fillColor;
  final Color? iconColor;
  final TextEditingController? controller;
  final String? hintText;

  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? suffix;
  final String? suffixText;

  final Widget? prefix;
  final Widget? prefixIcon;
  final String? prefixText;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final Function()? onTap;
  final Function(String)? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final bool autoValidate;
  final bool enableInteractiveSelection;
  final bool enabled;
  final EdgeInsets margin;
  final double titleSpacing;
  final EdgeInsets padding;

  //hardly needed options
  final TextStyle? hintStyle;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final TextAlign textAlign;
  final int? maxCharacters;
  final double borderRadius;
  final bool typeable;
  final bool autoFocus;
  final Function(bool hasFocus)? onFocusChange;
  final TextInputAction? textInputAction;

  final FutureOr<Iterable<T>> Function(String) suggestionsCallback;
  final Widget Function(BuildContext, T) itemBuilder;
  final Function(T) onSuggestionSelected;

  InputBorder inputBorder(Color color) {
    BorderSide borderSide = BorderSide(color: color);

    return OutlineInputBorder(
      borderSide: borderSide,
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = style ?? theme.textTheme.bodyMedium;
    return Padding(
      padding: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null) ...[
            RichText(
                text: TextSpan(
              text: title,
              style: titleStyle ??
                  theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
              children: validator != null
                  ? [
                      TextSpan(
                        text: '*',
                        style: textStyle?.copyWith(
                            color: theme.colorScheme.error, height: 1),
                      )
                    ]
                  : null,
            )),
            SizedBox(height: titleSpacing),
          ],
          TypeAheadFormField<T>(
            textFieldConfiguration: TextFieldConfiguration(
              controller: controller,
              autofocus: autoFocus,
              textCapitalization: textCapitalization,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: keyboardType ?? TextInputType.text,
              textInputAction: textInputAction,
              maxLines: maxLines ?? 1,
              focusNode: focusNode,
              onTap: onTap,
              onChanged: onChanged,
              onSubmitted: onFieldSubmitted,
              inputFormatters: inputFormatters,
              textAlign: textAlign,
              maxLength: maxCharacters,
              style: textStyle,
              enableInteractiveSelection: enableInteractiveSelection,
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              decoration: InputDecoration(
                enabled: enabled,
                filled: fillColor != null,
                fillColor: fillColor,
                hintText: hintText,
                errorStyle: theme.textTheme.labelLarge
                    ?.copyWith(color: theme.colorScheme.error),
                hintStyle:
                    hintStyle ?? textStyle?.copyWith(color: theme.hintColor),
                enabledBorder: inputBorder(theme.colorScheme.outline),
                disabledBorder: inputBorder(theme.disabledColor),
                focusedBorder: inputBorder(theme.colorScheme.primary),
                errorBorder: inputBorder(theme.colorScheme.error),
                isDense: false,
                contentPadding: padding,
                errorMaxLines: 2,
                prefixIconConstraints: BoxConstraints(
                  minWidth: theme.iconTheme.size! + padding.left,
                ),
                prefix: prefix,
                prefixIcon: prefixIcon,
                prefixIconColor: theme.hintColor,
                prefixText: prefixText,
                suffix: suffix,
                suffixIcon: suffixIcon,
                suffixIconColor: theme.hintColor,
                suffixText: suffixText,
              ),
            ),
            validator: validator,
            autovalidateMode: autoValidate
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            enabled: enabled,
            suggestionsCallback: suggestionsCallback,
            itemBuilder: itemBuilder,
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            onSuggestionSelected: onSuggestionSelected,
            debounceDuration: const Duration(milliseconds: 250),
            minCharsForSuggestions: 1,
            itemSeparatorBuilder: (context, index) => Divider(
              thickness: 0.5,
              height: 0.5,
              color: theme.colorScheme.onPrimary,
            ),
            noItemsFoundBuilder: (context) => const SizedBox.shrink(),
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(borderRadius),
              elevation: 4,
            ),
          ),
        ],
      ),
    );
  }
}
