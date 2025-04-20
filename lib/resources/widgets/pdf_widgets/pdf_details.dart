import 'package:billing/models/invoice.dart';
import 'package:billing/resources/constens.dart';
import 'package:billing/resources/widgets/common_pdfs/pdf_text.dart';
import 'package:billing/services/appStorage.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget invoiceDetailsPdf(
  double baseFontSize,
  double screenWidth,
  double height,
  Invoice invoice,
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
            _detailTextPdf("GST No", invoice.gstNumber, baseFontSize * 1.2, invoiRed),
            pw.SizedBox(height: 4),
            _detailTextPdf("Mobile No", invoice.mobileNo, baseFontSize* 1.2, invoiRed),
            pw.SizedBox(height: 4),
            _detailTextPdf("State Code", invoice.stateCode, baseFontSize, invoiRed),
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
            _detailTextPdf("Bill No", invoice.id.toString(), baseFontSize),
            pw.SizedBox(height: 4),
            _detailTextPdf("Date", invoice.date, baseFontSize),
            pw.SizedBox(height: 4),
            // _detailTextPdf("Challan No", invoice.chalanNo, baseFontSize),
          ],
        ),
      ),
    ],
  );
}


pw.Widget _detailTextPdf(String label, String value, double fontSize, [PdfColor? color = PdfColors.black]) {
  return pw.Row(
    children: [
      PDFText(
    data: "$label : \t",
    fontSize: fontSize,
    fontColor: color
  ),
  PDFText(
    data: value,
    fontSize: fontSize + (label=="Bill No" ? fontSize *.8:0),
    fontWeight: label=="Bill No" ?  pw.FontWeight.bold: pw.FontWeight.normal,
  )
    ]
  );
}
