import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

pw.Widget PDFBox({
  required String text,
  double width = double.infinity,
  double height = 60,
  PdfColor color = PdfColors.grey200,
  PdfColor textColor = PdfColors.black,
  double fontSize = 14,
  pw.EdgeInsets padding = const pw.EdgeInsets.all(10),
  pw.TextAlign align = pw.TextAlign.left,
  pw.FontWeight fontWeight = pw.FontWeight.normal,
  PdfColor? borderColor,
  double borderWidth = 1,
}) {
  return pw.Container(
    height: height,
    width: width,
    padding: padding,
    decoration: pw.BoxDecoration(
      color: color,
      border: borderColor != null
          ? pw.Border.all(color: borderColor, width: borderWidth)
          : null,
    ),
    alignment: pw.Alignment.centerLeft,
    child: pw.Text(
      text,
      textAlign: align,
      style: pw.TextStyle(
        fontSize: fontSize,
        color: textColor,
        fontWeight: fontWeight,
      ),
    ),
  );
}
