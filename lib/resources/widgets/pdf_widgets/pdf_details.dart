import 'package:billing/resources/widgets/common_pdfs/pdf_text.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget invoiceDetailsPdf(
  double baseFontSize,
  double screenWidth,
  dynamic configController,
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
            _detailTextPdf("GST No", configController.gstNumber.value, baseFontSize * 1.2),
            pw.SizedBox(height: 4),
            _detailTextPdf("PAN No", configController.panNumber.value, baseFontSize),
            pw.SizedBox(height: 4),
            _detailTextPdf("State Code", configController.stateCode.value, baseFontSize),
          ],
        ),
      ),

      // Divider
      pw.Container(
        width: 1,
        height: 60,
        color: PdfColors.black,
      ),

      // Right Section
      pw.Container(
        width: rightWidth,
        padding: const pw.EdgeInsets.symmetric(horizontal: 8),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _detailTextPdf("Invoice No", configController.invoiceNo.value, baseFontSize),
            pw.SizedBox(height: 4),
            _detailTextPdf("Date", "", baseFontSize),
            pw.SizedBox(height: 4),
            _detailTextPdf("Challan No", configController.chalanNo.value, baseFontSize),
          ],
        ),
      ),
    ],
  );
}


pw.Widget _detailTextPdf(String label, String value, double fontSize) {
  return PDFText(
    data: "$label: $value",
    fontSize: fontSize,
    fontWeight: pw.FontWeight.normal,
  );
}
