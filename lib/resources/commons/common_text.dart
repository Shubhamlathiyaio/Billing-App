import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String data;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const CommonText({
    Key? key,
    required this.data,
    this.fontSize,
    this.fontWeight = FontWeight.bold,
    this.fontColor,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.bodyMedium ?? const TextStyle();

    final effectiveStyle = (style ?? defaultStyle).copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: fontColor,
    );

    return Text(
      data,
      style: effectiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}


// AI Prompt to Add another functionaliti 👇
/*

You are an expert Flutter developer.  
I have a `CommonText` widget in Flutter. Here's the current code:  

[PASTE COMMONTEXT CODE HERE]  

👉 The widget currently supports:  
- `fontSize` – Custom size for the text.  
- `fontWeight` – Custom weight (default = bold).  
- `fontColor` – Custom color (defaults to theme).  
- `textAlign` – Aligns the text.  
- `maxLines` – Maximum number of lines.  
- `overflow` – Handles text overflow.  

💡 I want to modify this widget by **adding a new property**. Here’s what I need:  
1. [Describe the new property, e.g., "Add textScaler property to adjust text size"]  

🚀 **Update the code accordingly and provide the modified widget!**  


 */
