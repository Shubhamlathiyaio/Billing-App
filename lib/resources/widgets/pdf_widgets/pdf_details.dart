import 'package:billing/resources/widgets/common_pdfs/pdf_text.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget invoiceDetailsPdf(
  double baseFontSize,
  double screenWidth,
  double height,
  dynamic config,
) {
  final leftWidth = screenWidth * 0.5;
  final rightWidth = screenWidth * 0.45;

  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      // Left Section
      pw.Container(
        width: leftWidth,
        padding: const pw.EdgeInsets.symmetric(horizontal: 8),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _detailTextPdf("GST No", config.gstNumber, baseFontSize * 1.2),
            pw.SizedBox(height: 4),
            _detailTextPdf("PAN No", config.panNumber, baseFontSize),
            pw.SizedBox(height: 4),
            _detailTextPdf("State Code", config.stateCode, baseFontSize),
          ],
        ),
      ),

      // Divider
      pw.Container(
        width: 1,
        height: height * 0.05,
        color: PdfColors.black,
      ),

      // Right Section
      pw.Container(
        width: rightWidth,
        padding: const pw.EdgeInsets.symmetric(horizontal: 8),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _detailTextPdf("Invoice No", config.invoiceNo, baseFontSize),
            pw.SizedBox(height: 4),
            _detailTextPdf("Date", config.date, baseFontSize),
            pw.SizedBox(height: 4),
            // _detailTextPdf("Challan No", config.chalanNo, baseFontSize),
          ],
        ),
      ),
    ],
  );
}


pw.Widget _detailTextPdf(String label, String value, double fontSize) {
  return PDFText(
    data: "$label\t: $value",
    fontSize: fontSize,
    fontWeight: pw.FontWeight.normal
  );
}
