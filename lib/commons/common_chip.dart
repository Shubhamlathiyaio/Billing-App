import 'package:flutter/material.dart';

class CommonChip extends StatelessWidget {
  final dynamic child; // ✅ Accept String or Widget
  final double horizontalPadding;
  final double verticalPadding;
  final double radius;
  final Color backgroundColor;
  final IconData? icon;
  final Color? iconColor;
  final double iconSize;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final AlignmentGeometry alignment; // ✅ Custom child alignment

  const CommonChip({
    Key? key,
    required this.child,
    this.horizontalPadding = 12,
    this.verticalPadding = 5,
    this.radius = 15,
    this.backgroundColor = Colors.black26,
    this.icon,
    this.iconColor,
    this.iconSize = 18,
    this.height,
    this.width,
    this.textStyle,
    this.alignment = Alignment.centerLeft, // Default alignment
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 0,
        maxWidth: width ?? double.infinity,
      ),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: backgroundColor,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: iconSize,
                color: iconColor ?? Colors.white,
              ),
              const SizedBox(width: 4),
            ],
            Expanded(
              // ✅ Allows proper alignment
              child: Align(
                alignment: alignment,
                child: child is String
                    ? Text(child,
                        style:
                            textStyle ?? const TextStyle(color: Colors.white))
                    : child as Widget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
