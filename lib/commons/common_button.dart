import 'package:flutter/material.dart';
import 'package:billing/commons/common_spacing.dart';
import 'package:billing/commons/common_text.dart';

enum IconDirection { top, bottom, left, right }

class CommonButton extends StatelessWidget {
  final dynamic text; // Accepts both String and Widget
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Gradient? gradient;
  final Color? textColor;
  final double borderRadius;
  final double fontSize;
  final ImageProvider? icon;
  final IconDirection iconDirection;
  final double? height;
  final double? width;
  final double verticalPadding; // New
  final double horizontalPadding; // New

  const CommonButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.gradient,
    this.textColor,
    this.borderRadius = 8.0,
    this.fontSize = 16.0,
    this.icon,
    this.iconDirection = IconDirection.left,
    this.height,
    this.width,
    this.verticalPadding = 12.0, // Default value
    this.horizontalPadding = 16.0, // Default value
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget iconWidget = icon != null
        ? Image(
            image: icon!,
            width: 24,
            height: 24,
          )
        : const SizedBox();

    Widget textWidget = text is String
        ? CommonText(
            data: text,
            style: TextStyle(
              fontSize: fontSize,
              color: textColor ?? theme.colorScheme.onPrimary,
            ),
          )
        : text as Widget;

    List<Widget> children = [];
    switch (iconDirection) {
      case IconDirection.left:
        children = [iconWidget, if (icon != null) w8, textWidget];
        break;
      case IconDirection.right:
        children = [textWidget, if (icon != null) w8, iconWidget];
        break;
      case IconDirection.top:
        children = [iconWidget, if (icon != null) h4, textWidget];
        break;
      case IconDirection.bottom:
        children = [textWidget, if (icon != null) h4, iconWidget];
        break;
    }

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding, // Apply vertical padding
          horizontal: horizontalPadding, // Apply horizontal padding
        ),
        decoration: BoxDecoration(
          color:
              gradient == null ? backgroundColor ?? theme.primaryColor : null,
          gradient: gradient,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: iconDirection == IconDirection.top ||
                iconDirection == IconDirection.bottom
            ? Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
      ),
    );
  }
}





// AI Prompt to Add another functionaliti 👇
/*

**"Add a new property `[???]` to `CommonButton`. Follow these guidelines:** 
- 🛠️ Add sensible padding between the icon and text.  
- ✅ Keep the core structure unchanged.  
- 🎯 Ensure the button remains responsive and well-aligned."  

*/