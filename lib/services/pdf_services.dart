import 'dart:io';
import 'package:billing/controllers/config_controller.dart';
import 'package:billing/controllers/invoice_controller.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PDFServices {
  /// Generates the PDF and returns the file path
   static Future<File> generatePDF() async {
    final configController = Get.find<ConfigController>();
    final invoiceController = Get.find<InvoiceController>();
    
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  configController.companyName.value,
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Center(
                child: pw.Text(configController.address.value),
              ),
              pw.Divider(),
              pw.Center(
                child: pw.Text(
                  "Invoice",
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("GST No: ${configController.gstNumber.value}"),
                      pw.Text("PAN No: ${configController.panNumber.value}"),
                      pw.Text("State Code: ${configController.stateCode.value}"),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Invoice No: ${invoiceController.invoiceNo.value}"),
                      pw.Text("Date: ${invoiceController.date.value}"),
                      pw.Text("Challan No: ${invoiceController.challanNo.value}"),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(children: [
                    pw.Text("Sr No", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text("Description", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text("Qty", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text("Rate", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text("Amount", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ]),
                  ...invoiceController.items.map((item) => pw.TableRow(children: [
                        pw.Text(item.srNo),
                        pw.Text(item.description),
                        pw.Text(item.qty),
                        pw.Text(item.rate),
                        pw.Text(item.amount),
                      ])).toList(),
                ],
              ),
              pw.Divider(),
              pw.Text("Final Total: ${invoiceController.finalTotal.value}"),
              pw.Text("Amount in Words: ${invoiceController.amountInWords.value}"),
              pw.Divider(),
              pw.Text("Terms & Conditions:"),
              pw.Text(invoiceController.terms.value),
            ],
          );
        },
      ),
    );

    final output = await getApplicationDocumentsDirectory();
    final file = File("${output.path}/invoice.pdf");
    await file.writeAsBytes(await pdf.save());

    return file;
  }

  /// Shares the generated PDF file
  static Future<void> sharePDF(String path) async {
    await Share.shareXFiles([XFile(path)], text: "Here is your invoice PDF.");
  }
}
