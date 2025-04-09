import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFText extends pw.StatelessWidget {
  final String data;
  final double? fontSize;
  final pw.FontWeight? fontWeight;
  final PdfColor? fontColor;
  final pw.TextAlign? align; // ✅ added align alias
  final int? maxLines;

  PDFText({
    required this.data,
    this.fontSize,
    this.fontWeight = pw.FontWeight.bold,
    this.fontColor = PdfColors.black,
    this.align, // ✅ include align in constructor
    this.maxLines,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Text(
      data,
      maxLines: maxLines,
      textAlign: align, // ✅ use align instead of textAlign
      style: pw.TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: fontColor,
      ),
    );
  }
}
