import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final Color? cursorColor;
  final TextStyle? style;
  final Color? iconColor;
  final Color? borderColor;
  final TextStyle? hintTextStyle;
  final String? hintText;
  final Color? enabledColor;
  final FormFieldValidator<String>? validator;
  final bool obscure;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final AutovalidateMode? autoValidateMode;
  final TextStyle? errorStyle;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final bool enabled;
  final InputBorder? border;
  final String? label;
  final TextStyle? labelStyle;
  final String? errorText;
  final Color? errorBorderColor;
  final int? errorMaxLines;
  final Color? cursorErrorColor;
  final EdgeInsets? contentPadding;
  final bool readOnly;
  final void Function()? onSuffixIconPressed;

  const CustomTextFormFieldWidget({
    super.key,
    this.controller,
    this.cursorColor,
    this.style,
    this.iconColor,
    this.borderColor,
    this.hintTextStyle,
    this.hintText,
    this.enabledColor,
    this.validator,
    this.obscure = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.autoValidateMode,
    this.errorStyle,
    this.inputFormatters,
    this.onChanged,
    this.enabled = true,
    this.border,
    this.label,
    this.labelStyle,
    this.errorText,
    this.errorBorderColor,
    this.errorMaxLines,
    this.cursorErrorColor,
    this.contentPadding = const EdgeInsets.only(top: 16),
    this.readOnly = false,
    this.onSuffixIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        cursorErrorColor: cursorErrorColor,
        style: style,
        obscureText: obscure,
        validator: validator,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        keyboardType: keyboardType,
        autovalidateMode: autoValidateMode,
        decoration: InputDecoration(
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: suffixIcon!,
                  onPressed: onSuffixIconPressed,
                )
              : null,
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: hintTextStyle,
          labelText: label,
          labelStyle: labelStyle,
          enabled: enabled,
          contentPadding: contentPadding,
          errorText: errorText,
          errorStyle: errorStyle,
          errorMaxLines: errorMaxLines,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? Colors.grey,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: enabledColor ?? Colors.grey,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: errorBorderColor ?? Colors.red,
            ),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: errorBorderColor ?? Colors.red,
            ),
          ),
          border: border,
        ),
      ),
    );
  }
}
