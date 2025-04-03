import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PDFServices {
  /// Generates the PDF file and returns its path
  static Future<File> generatePDF(String item, String price) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => pw.Padding(
          padding: pw.EdgeInsets.all(32),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("🧾 Invoice",
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text("Item: $item", style: pw.TextStyle(fontSize: 18)),
              pw.Text("Price: \$$price", style: pw.TextStyle(fontSize: 18)),
              pw.SizedBox(height: 20),
              pw.Text("Total: \$$price",
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold)),
            ],
          ),
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/invoice.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Shares the existing PDF
  static Future<void> sharePDF(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await Printing.sharePdf(
          bytes: await file.readAsBytes(), filename: "invoice.pdf");
    }
  }
}
