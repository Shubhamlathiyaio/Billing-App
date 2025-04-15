import 'dart:io';
import 'package:billing/controllers/config_controller.dart';
import 'package:billing/resources/commons/common_get_snackbar.dart';
import 'package:billing/resources/widgets/pdf_body.dart';
import 'package:get/get.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PdfServices {
  // 1. Generate PDF in memory (not saved anywhere, only returned as a file).
  static Future<File> generatePdfInMemory(int id) async {
    try {
      final pdf = getPdfDoc(id);
      final data = await pdf.save();
      final file =
          File('${(await getTemporaryDirectory()).path}/temp_invo_$id.pdf');
      await file.writeAsBytes(data);
      return file;
    } catch (e) {
      Get.snackbar("PDF Error", "Could not generate PDF in memory: $e");
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
    final file = await generatePdfInMemory(fileName.hashCode);
    await Share.shareXFiles([XFile(file.path)], text: "Invoice Share");
  }

  // 5. Open the saved PDF for user to view.
  static Future<void> openPdf(File file) async {
    await OpenFile.open(file.path);
  }

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

  // Helper function: Generate PDF document based on ID.
  static pw.Document getPdfDoc(int id) {
    final pdf = pw.Document();
    // Get.find<ConfigController>().invoiceToConfig(Get.find<StorageController>().getInvoiceById(id));
    ConfigController config = Get.find<ConfigController>();
    // Replace this with your actual PDF generation code
    pdf.addPage(
      pw.Page(
        build: (context) => invoiceBodyPdf(config,context.page.pageFormat.width, id),
      ),
    );
    return pdf;
  }
}
