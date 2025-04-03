import 'package:flutter/material.dart';

class CommonBoxDecoration {
  static BoxDecoration ui({
    Color borderColor = Colors.black26,
    double horizontalBorderWidth = 0,
    double verticalBorderWidth = 0,
    double topBorderWidth = 0,
    double bottomBorderWidth = 0,
    double leftBorderWidth = 0,
    double rightBorderWidth = 0,
    double borderRadius = 0,
    Color backgroundColor = Colors.transparent,
  }) {
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border(
        top: BorderSide(color: borderColor, width: topBorderWidth > 0 ? topBorderWidth : verticalBorderWidth),
        bottom: BorderSide(color: borderColor, width: bottomBorderWidth > 0 ? bottomBorderWidth : verticalBorderWidth),
        left: BorderSide(color: borderColor, width: leftBorderWidth > 0 ? leftBorderWidth : horizontalBorderWidth),
        right: BorderSide(color: borderColor, width: rightBorderWidth > 0 ? rightBorderWidth : horizontalBorderWidth),
      ),
    );
  }
}
