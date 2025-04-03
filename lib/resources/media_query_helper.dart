import 'package:flutter/material.dart';
// if not useing DYNAMIC SCREEN SIZE during the run and STATE MANAGEMENT system
//                         👆                                 👆
// YOU CAN MAKE THE Object OF THIS CLASS
class MediaQueryHelper {
  final BuildContext context;

  MediaQueryHelper(this.context);

  Size get size => MediaQuery.of(context).size;
  double get screenWidth => size.width;
  double get screenHeight => size.height;
  double get minSide => size.shortestSide;
  double get maxSide => size.longestSide;
  double get screenRatio => size.width / size.height;
  double get statusBarHeight => MediaQuery.of(context).padding.top;
  double get bottomPadding => MediaQuery.of(context).padding.bottom;
  double get appBarHeight => kToolbarHeight; // Default AppBar height
}
