import 'package:flutter/material.dart';

class CommonBoxDecoration {
  static BoxDecoration ui({
    Color borderColor = Colors.black,
    double verticalBorderWidth = 0,
    double horizontalBorderWidth = 0,
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
        top: (topBorderWidth > 0 || horizontalBorderWidth > 0)
            ? BorderSide(
                color: borderColor,
                width:
                    topBorderWidth > 0 ? topBorderWidth : horizontalBorderWidth)
            : BorderSide.none,
        bottom: (bottomBorderWidth > 0 || horizontalBorderWidth > 0)
            ? BorderSide(
                color: borderColor,
                width: bottomBorderWidth > 0
                    ? bottomBorderWidth
                    : horizontalBorderWidth)
            : BorderSide.none,
        left: (leftBorderWidth > 0 || verticalBorderWidth > 0)
            ? BorderSide(
                color: borderColor,
                width: leftBorderWidth > 0 ? leftBorderWidth : verticalBorderWidth)
            : BorderSide.none,
        right: (rightBorderWidth > 0 || verticalBorderWidth > 0)
            ? BorderSide(
                color: borderColor,
                width: rightBorderWidth > 0 ? rightBorderWidth : verticalBorderWidth)
            : BorderSide.none,
      ),
    );
  }
}
