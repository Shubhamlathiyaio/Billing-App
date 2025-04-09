import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class PDFContainer extends pw.StatelessWidget {
  final pw.Widget child;
  final PdfColor borderColor;
  final double allBorder;
  final double verticalBorder;
  final double horizontalBorder;
  final double topBorder;
  final double bottomBorder;
  final double leftBorder;
  final double rightBorder;
  final double borderRadius;
  final PdfColor backgroundColor;
  final pw.EdgeInsets? padding;
  final bool centerAlign;
  final double? height;
  final double? width;
  final pw.Alignment alignment;

  PDFContainer({
    required this.child,
    this.borderColor = PdfColors.black,
    this.allBorder = 0,
    this.verticalBorder = 0,
    this.horizontalBorder = 0,
    this.topBorder = 0,
    this.bottomBorder = 0,
    this.leftBorder = 0,
    this.rightBorder = 0,
    this.borderRadius = 0,
    this.backgroundColor = PdfColors.white,
    this.padding,
    this.centerAlign = false,
    this.height,
    this.width,
    this.alignment = pw.Alignment.centerLeft,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      height: height,
      width: width,
      padding: padding,
      decoration: pw.BoxDecoration(
        color: backgroundColor,
        border: pw.Border(
          top: pw.BorderSide(
              color: borderColor,
              width: allBorder > 0
                  ? allBorder
                  : (topBorder > 0 ? topBorder : horizontalBorder)),
          bottom: pw.BorderSide(
              color: borderColor,
              width: allBorder > 0
                  ? allBorder
                  : (bottomBorder > 0 ? bottomBorder : horizontalBorder)),
          left: pw.BorderSide(
              color: borderColor,
              width: allBorder > 0
                  ? allBorder
                  : (leftBorder > 0 ? leftBorder : verticalBorder)),
          right: pw.BorderSide(
              color: borderColor,
              width: allBorder > 0
                  ? allBorder
                  : (rightBorder > 0 ? rightBorder : verticalBorder)),
        ),
      ),
      alignment: centerAlign ? pw.Alignment.center : alignment,
      child: child,
    );
  }
}
