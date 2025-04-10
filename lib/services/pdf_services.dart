import 'dart:io';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:billing/controllers/config_controller.dart';
import 'package:billing/resources/widgets/pdf_body.dart';

class PdfServices {
  /// Generate a basic empty PDF (optional usage)
  static Future<File> generateEmptyPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(); // Add content if needed
        },
      ),
    );

    return savePdf(name: 'invoice.pdf', pdf: pdf);
  }

  /// Generate a simple PDF with your invoice layout
  static Future<File> generateInvoicePdf() async {
    final config = Get.find<ConfigController>();
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) =>
            invoiceBodyPdf(config, context.page.pageFormat.width),
      ),
    );

    return savePdf(name: 'simple_invoice.pdf', pdf: pdf);
  }

  /// Save the PDF document to a file
  static Future<File> savePdf({
    required String name,
    required pw.Document pdf,
  }) async {
    final dir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    final file = File('${dir!.path}/$name');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Open a PDF file using the system's default viewer
  static Future<void> openPdf(File file) async {
    await OpenFile.open(file.path);
  }

  /// Share the PDF file
  static Future<void> sharePdf(File file, {String? message}) async {
    await Share.shareXFiles(
      [XFile(file.path)],
      text: message ?? "Here is your invoice PDF.",
    );
  }
}
