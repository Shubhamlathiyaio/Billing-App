import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final double allBorder;
  final double verticalBorder;
  final double horizontalBorder;
  final double topBorder;
  final double bottomBorder;
  final double leftBorder;
  final double rightBorder;
  final double borderRadius;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool centerAlign;
  final double? height;
  final double? width;
  final AlignmentGeometry alignment; // New property

  const CommonContainer({
    super.key,
    required this.child,
    this.borderColor = Colors.black,
    this.allBorder = 0,
    this.verticalBorder = 0,
    this.horizontalBorder = 0,
    this.topBorder = 0,
    this.bottomBorder = 0,
    this.leftBorder = 0,
    this.rightBorder = 0,
    this.borderRadius = 0,
    this.backgroundColor = Colors.transparent,
    this.padding,
    this.margin,
    this.centerAlign = false,
    this.height,
    this.width,
    this.alignment = Alignment.centerLeft, // Default alignment
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border(
          top: allBorder > 0 || topBorder > 0 || horizontalBorder > 0
              ? BorderSide(
                  color: borderColor,
                  width: allBorder > 0
                      ? allBorder
                      : (topBorder > 0 ? topBorder : horizontalBorder))
              : BorderSide.none,
          bottom: allBorder > 0 || bottomBorder > 0 || horizontalBorder > 0
              ? BorderSide(
                  color: borderColor,
                  width: allBorder > 0
                      ? allBorder
                      : (bottomBorder > 0 ? bottomBorder : horizontalBorder))
              : BorderSide.none,
          left: allBorder > 0 || leftBorder > 0 || verticalBorder > 0
              ? BorderSide(
                  color: borderColor,
                  width: allBorder > 0
                      ? allBorder
                      : (leftBorder > 0 ? leftBorder : verticalBorder))
              : BorderSide.none,
          right: allBorder > 0 || rightBorder > 0 || verticalBorder > 0
              ? BorderSide(
                  color: borderColor,
                  width: allBorder > 0
                      ? allBorder
                      : (rightBorder > 0 ? rightBorder : verticalBorder))
              : BorderSide.none,
        ),
      ),
      child: centerAlign
          ? Center(child: child)
          : Align(alignment: alignment, child: child),
    );
  }
}
