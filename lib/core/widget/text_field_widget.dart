import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    this.title,
    this.titleStyle,
    this.fillColor,
    this.iconColor,
    this.controller,
    this.hintText,
    this.obscureText = false,
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
  });

  final String? title;
  final TextStyle? titleStyle;
  final Color? fillColor;
  final Color? iconColor;
  final TextEditingController? controller;
  final String? hintText;

  final String? Function(String?)? validator;
  final bool obscureText;
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

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late bool isPassword;

  @override
  void initState() {
    isPassword = widget.obscureText;
    super.initState();
  }

  InputBorder inputBorder(Color color) {
    BorderSide borderSide = BorderSide(color: color);

    return OutlineInputBorder(
      borderSide: borderSide,
      borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = widget.style ?? theme.textTheme.bodyMedium;
    return Padding(
      padding: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.title != null) ...[
            RichText(
                text: TextSpan(
              text: widget.title,
              style: widget.titleStyle ??
                  theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
              children: widget.validator != null
                  ? [
                      TextSpan(
                        text: '*',
                        style: textStyle?.copyWith(
                            color: theme.colorScheme.error, height: 1),
                      )
                    ]
                  : null,
            )),
            SizedBox(height: widget.titleSpacing),
          ],
          TextFormField(
            autofocus: widget.autoFocus,
            readOnly: !widget.typeable,
            textCapitalization: widget.textCapitalization,
            controller: widget.controller,
            obscureText: isPassword,
            textAlignVertical: TextAlignVertical.center,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            maxLines: widget.maxLines ?? 1,
            focusNode: widget.focusNode,
            onTap: widget.onTap,
            onFieldSubmitted: widget.onFieldSubmitted,
            onChanged: widget.onChanged,
            autovalidateMode: widget.autoValidate
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            inputFormatters: widget.inputFormatters,
            textAlign: widget.textAlign,
            maxLength: widget.maxCharacters,
            style: textStyle,
            enableInteractiveSelection: widget.enableInteractiveSelection,
            enabled: widget.enabled,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            decoration: InputDecoration(
              enabled: widget.enabled,
              filled: widget.fillColor != null,
              fillColor: widget.fillColor,
              hintText: widget.hintText,
              errorStyle: theme.textTheme.labelLarge
                  ?.copyWith(color: theme.colorScheme.error),
              hintStyle: widget.hintStyle ??
                  textStyle?.copyWith(color: theme.hintColor),
              enabledBorder: inputBorder(theme.colorScheme.outline),
              disabledBorder: inputBorder(theme.disabledColor),
              focusedBorder: inputBorder(theme.colorScheme.primary),
              errorBorder: inputBorder(theme.colorScheme.error),
              isDense: false,
              contentPadding: widget.padding,
              errorMaxLines: 2,
              prefixIconConstraints: BoxConstraints(
                minWidth: theme.iconTheme.size! + widget.padding.left,
              ),
              prefix: widget.prefix,
              prefixIcon: widget.prefixIcon,
              prefixIconColor: theme.hintColor,
              prefixText: widget.prefixText,
              suffix: widget.suffix,
              suffixIcon: widget.suffixIcon ??
                  (widget.obscureText
                      ? InkWell(
                          child: Center(
                            widthFactor: 1,
                            child: Icon(
                              isPassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 24,
                              color: theme.colorScheme.outline,
                            ),
                          ),
                          onTap: () {
                            setState(() => isPassword = !isPassword);
                          },
                        )
                      : null),
              suffixIconColor: theme.hintColor,
              suffixText: widget.suffixText,
            ),
          ),
        ],
      ),
    );
  }
}
