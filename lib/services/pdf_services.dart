import 'dart:io';
import 'package:billing/controllers/config_controller.dart';
import 'package:billing/controllers/table_controller.dart';
import 'package:billing/models/invoice.dart';
import 'package:billing/resources/commons/common_get_snackbar.dart';
import 'package:billing/resources/widgets/pdf_body.dart';
import 'package:get/get.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PdfServices {
  static pw.Document getPdfDoc(Invoice invoice) {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => invoiceBodyPdf(
          invoice, // Pass unsavedInvoice instead of config
          context.page.pageFormat.width,
        ),
      ),
    );
    return pdf;
  }

  static Future<File> generatePdfInMemory(Invoice invoice) async {
    print("objec888888888888888888ts: ${invoice.companyName}");
    try {
      final pdf = getPdfDoc(invoice);
      final data = await pdf.save();
      final file = File(
          '${(await getTemporaryDirectory()).path}/temp_invo_${invoice.id}.pdf');
      await file.writeAsBytes(data);
      return file;
    } catch (e) {
      Get.snackbar("PDF Error", "Could not generate PDF in memory: $e",
          animationDuration: Duration(seconds: 10));
      throw Exception("PDF generation failed.");
    }
  }

  // 2. Save PDF to disk in a temporary location (user won't see it).
  static Future<void> savePdfInMemory(pw.Document pdf, String fileName) async {
    try {
      final dir = await getTemporaryDirectory();
      final path = '${dir.path}/$fileName.pdf';
      final file = File(path);
      await file.writeAsBytes(await pdf.save());
      Get.find<ConfigController>().clearOtherConfigDataOnly();
    } catch (e) {
      Get.snackbar("PDF Error", "Could not save PDF in memory: $e");
    }
  }

  // 3. Download PDF to the device and allow user to see it.
  static Future<void> downloadPdf(pw.Document pdf, String fileName) async {
    final dir = await getExternalStorageDirectory(); // App-specific
    final path = '${dir!.path}/Billing App/$fileName.pdf';
    final file = File(path);

    if (await file.exists()) {
      CommonSnackbar.errorSnackbar(
          "File already exists", "A file with the same name already exists.");
      return;
    }

    try {
      await file.writeAsBytes(await pdf.save());
      CommonSnackbar.successSnackbar("Downloaded", "PDF saved to Downloads");
    } catch (e) {
      CommonSnackbar.errorSnackbar("PDF Error", "Failed to save PDF: $e");
    }
  }

  // 4. Share the PDF without showing it (it is saved temporarily and shared).
  static Future<void> sharePdf(pw.Document pdf, String fileName) async {
    // 1. Get temporary directory
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName.pdf');
    await file.create(recursive: true);

    // 2. Write the PDF document to file
    final pdfBytes = await pdf.save();
    await file.writeAsBytes(pdfBytes);

    // 3. Share the file
    await Share.shareXFiles(
      [XFile(file.path)],
      text: "📄 Invoice: $fileName",
    );
  }
  // Helper function: Generate PDF document based on ID.

  // 5. Open the saved PDF for user to view.
  static Future<void> openPdf(File file) async =>
      await OpenFile.open(file.path);

  // 6. Delete a PDF file (either in memory or storage).
  static Future<void> deletePdf(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
      CommonSnackbar.successSnackbar(
          "File deleted", "PDF file deleted successfully.");
    } else {
      CommonSnackbar.errorSnackbar(
          "File not found", "The PDF file could not be found.");
    }
  }
}
