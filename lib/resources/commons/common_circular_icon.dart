import 'package:flutter/material.dart';

class CommonCircularIcon extends StatelessWidget {
  final Widget icon;
  final double size;
  final Color? ringColor;
  final bool withRing;
  final double ringWidth;

  const CommonCircularIcon({
    Key? key,
    required this.icon,
    this.size = 40,
    this.ringColor,
    this.withRing = false,
    this.ringWidth = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double platformSize = withRing || ringColor != null
        ? size - (ringWidth * 2) - 5
        : size;

    return Stack(
      alignment: Alignment.center,
      children: [
        if (withRing || ringColor != null) // ✅ Draw ring if enabled
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ringColor ?? Colors.white,
                width: ringWidth,
              ),
            ),
          ),
        Container(
          width: platformSize,
          height: platformSize,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.50), // ✅ 25% opacity white color
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all((withRing || ringColor != null) ? 5 : 10),
            child: icon,
          ),
        ),
      ],
    );
  }
}
