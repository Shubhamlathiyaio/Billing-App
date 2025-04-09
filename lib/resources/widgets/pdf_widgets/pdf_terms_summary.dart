import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;


pw.Widget termsAndConditionsSectionPdf(double fontSize) {
  final terms = [
    "1) Complaint, if any, regarding this Invoice must be settled immediately.",
    "2) Goods once sold will not be taken back or exchanged.",
    "3) Goods are dispatched to the account and risk of the buyer.",
    "4) Interest @2% per month will be charged on the amount remaining unpaid from the due date.",
    "5) Subject to SURAT Jurisdiction.",
  ];

  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      // Terms Section
      pw.Expanded(
        flex: 5,
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "Terms and Conditions:-",
              style: pw.TextStyle(
                fontSize: fontSize,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: fontSize * 0.6),
            for (var term in terms)
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 4, left: 8),
                child: pw.Text(
                  term,
                  style: pw.TextStyle(fontSize: fontSize * 0.85),
                ),
              ),
          ],
        ),
      ),

      // Signature Box
      pw.Expanded(
        flex: 2,
        child: pw.Container(
          height: 100,
          padding: const pw.EdgeInsets.all(8),
          alignment: pw.Alignment.center,
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("For Your Company", style: pw.TextStyle(fontSize: fontSize)),
              pw.SizedBox(height: 40),
              pw.Text("Auth. Sign.", style: pw.TextStyle(fontSize: fontSize)),
            ],
          ),
        ),
      )
    ],
  );
}
