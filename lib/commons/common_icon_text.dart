import 'package:flutter/material.dart';

class CommonIconText extends StatelessWidget {
  final dynamic child; // Can be String or Widget
  final dynamic icon; // Can be String, Widget, Image, Icon, or SVG
  final Axis direction; // Icon placement direction
  final double iconPadding;
  final double childPadding;

  const CommonIconText({
    Key? key,
    required this.child,
    required this.icon,
    this.direction = Axis.horizontal, // Default: icon beside text
    this.iconPadding = 5,
    this.childPadding = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget childWidget = (child is String)
        ? Text(child, style: TextStyle(fontSize: 16))
        : child;

    Widget iconWidget = (icon is String)
        ? Text(icon, style: TextStyle(fontSize: 16)) // String icon
        : (icon is Widget)
            ? icon // Any widget (Image, Icon, SVG, etc.)
            : Icon(Icons.error, color: Colors.red); // Fallback icon

    return direction == Axis.horizontal
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              iconWidget,
              SizedBox(width: iconPadding),
              childWidget,
              SizedBox(width: childPadding),
            ],
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              iconWidget,
              SizedBox(height: iconPadding),
              childWidget,
              SizedBox(height: childPadding),
            ],
          );
  }
}
