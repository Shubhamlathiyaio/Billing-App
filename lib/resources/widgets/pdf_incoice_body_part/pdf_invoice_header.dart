import 'package:billing/controllers/config_controller.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget pdfCompanyHeader(ConfigController configController) {
  return pw.Column(
    children: [
      pw.Center(
        child: pw.Text(
          configController.companyName.value,
          style: pw.TextStyle(
            fontSize: 22, // baseFontSize * LARGE
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ),
      pw.SizedBox(height: 4),
      pw.Center(
        child: pw.Text(
          configController.address.value,
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
            fontSize: 10, // baseFontSize
          ),
        ),
      ),
      pw.SizedBox(height: 6),
      pw.Container(
        alignment: pw.Alignment.center,
        width: double.infinity,
        decoration: pw.BoxDecoration(
          border: pw.Border.symmetric(
            horizontal: pw.BorderSide(width: 1),
          ),
        ),
        padding: const pw.EdgeInsets.symmetric(vertical: 4),
        child: pw.Text(
          "Invoice",
          style: pw.TextStyle(
            fontSize: 14, // baseFontSize * MEDIUM
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}
