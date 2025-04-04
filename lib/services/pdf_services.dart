import 'dart:io';
import 'package:billing/controllers/config_controller.dart';
import 'package:billing/controllers/invoice_controller.dart';
import 'package:billing/resources/widgets/pdf_invoice_body.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PDFServices {
  /// Generates the PDF and returns the file path
   static Future<File> generatePDF(BuildContext context) async {
    final configController = Get.find<ConfigController>();
    final invoiceController = Get.find<InvoiceController>();
    
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context contex) {
          return pdfInvoiceBody(context); },
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
