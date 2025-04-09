import 'package:billing/resources/widgets/common_pdfs/pdf_conatiner.dart';
import 'package:billing/resources/widgets/common_pdfs/pdf_text.dart';
import 'package:billing/resources/constens.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget companyHeaderPdf(
  double baseFontSize,
  double screenWidth,
  dynamic configController,
) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.center,
    children: [
      pw.SizedBox(height: 4),
      PDFText(
        data: configController.companyName.value,
        fontSize: baseFontSize * LARGE,
        fontWeight: pw.FontWeight.bold,
        align: pw.TextAlign.center,
      ),
      pw.SizedBox(height: 2),
      PDFText(
        data: configController.address.value,
        fontSize: baseFontSize,
        maxLines: 2,
        align: pw.TextAlign.center,
      ),
      pw.SizedBox(height: 6),
      PDFContainer(
        width: screenWidth,
        padding: const pw.EdgeInsets.symmetric(vertical: 2),
        horizontalBorder: LINEWIDTH,
        centerAlign: true,
        child: PDFText(
          data: "Invoice",
          fontSize: baseFontSize * MEDIUM,
          fontWeight: pw.FontWeight.bold,
          align: pw.TextAlign.center,
        ),
      ),
      pw.SizedBox(height: 2),
    ],
  );
}
