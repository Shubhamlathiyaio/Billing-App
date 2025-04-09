import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final dynamic label; // Accepts String or Widget
  final String? hintText; // 🔹 Added hintText
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

  const CommonTextField({
    Key? key,
    this.label,
    this.hintText, // 🔹 Constructor
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 0,
        vertical: verticalPadding ?? 5,
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(color: textColor),
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label is String ? label : null,
          label: label is Widget ? label : null,
          hintText: hintText, // 🔹 Set hintText here
          prefixIcon:
              prefixIcon != null ? Icon(prefixIcon, color: textColor) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide:
                BorderSide(color: borderColor, width: borderWidth + 0.5),
          ),
        ),
      ),
    );
  }
}
