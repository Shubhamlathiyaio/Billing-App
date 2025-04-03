import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final double allBorderWidth;
  final double horizontalBorderWidth;
  final double verticalBorderWidth;
  final double topBorderWidth;
  final double bottomBorderWidth;
  final double leftBorderWidth;
  final double rightBorderWidth;
  final double borderRadius;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool centerAlign;
  final double? height;
  final double? width;

  const CommonContainer({
    Key? key,
    required this.child,
    this.borderColor = Colors.black,
    this.allBorderWidth = 0, // New parameter for all borders
    this.horizontalBorderWidth = 0,
    this.verticalBorderWidth = 0,
    this.topBorderWidth = 0,
    this.bottomBorderWidth = 0,
    this.leftBorderWidth = 0,
    this.rightBorderWidth = 0,
    this.borderRadius = 0,
    this.backgroundColor = Colors.transparent,
    this.padding,
    this.margin,
    this.centerAlign = false,
    this.height,
    this.width,
  }) : super(key: key);

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
          top: allBorderWidth > 0 || topBorderWidth > 0 || verticalBorderWidth > 0
              ? BorderSide(color: borderColor, width: allBorderWidth > 0 ? allBorderWidth : (topBorderWidth > 0 ? topBorderWidth : verticalBorderWidth))
              : BorderSide.none,
          bottom: allBorderWidth > 0 || bottomBorderWidth > 0 || verticalBorderWidth > 0
              ? BorderSide(color: borderColor, width: allBorderWidth > 0 ? allBorderWidth : (bottomBorderWidth > 0 ? bottomBorderWidth : verticalBorderWidth))
              : BorderSide.none,
          left: allBorderWidth > 0 || leftBorderWidth > 0 || horizontalBorderWidth > 0
              ? BorderSide(color: borderColor, width: allBorderWidth > 0 ? allBorderWidth : (leftBorderWidth > 0 ? leftBorderWidth : horizontalBorderWidth))
              : BorderSide.none,
          right: allBorderWidth > 0 || rightBorderWidth > 0 || horizontalBorderWidth > 0
              ? BorderSide(color: borderColor, width: allBorderWidth > 0 ? allBorderWidth : (rightBorderWidth > 0 ? rightBorderWidth : horizontalBorderWidth))
              : BorderSide.none,
        ),
      ),
      child: centerAlign ? Center(child: child) : child,
    );
  }
}
