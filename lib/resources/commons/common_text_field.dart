import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatelessWidget {
  final dynamic label; // Accepts String or Widget
  final String? hintText;
  final IconData? prefixIcon;
  final bool isPassword;
  final Color borderColor;
  final Color textColor;
  final double borderWidth;
  final double borderRadius;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextEditingController? controller;
  final double? horizontalPadding;
  final double? verticalPadding;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  const CommonTextField({
    Key? key,
    this.label,
    this.hintText,
    this.prefixIcon,
    this.isPassword = false,
    this.borderColor = Colors.black26,
    this.textColor = Colors.black,
    this.borderWidth = 1.5,
    this.borderRadius = 5,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.words,
    this.controller,
    this.horizontalPadding,
    this.verticalPadding,
    this.onChanged,
    this.maxLines,
    this.maxLength,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labelText = label is String ? label : null;
    final labelWidget = label is Widget ? label : null;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: borderColor, width: borderWidth),
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 0,
        vertical: verticalPadding ?? 5,
      ),
      child: TextField(
        maxLines: maxLines ?? 1,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(color: textColor),
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          label: labelWidget,
          hintText: hintText,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: textColor)
              : null,
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: border.borderSide.copyWith(width: borderWidth + 0.5),
          ),
        ),
      ),
    );
  }
}
