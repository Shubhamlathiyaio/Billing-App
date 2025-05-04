import 'dart:io';
import 'package:billing/controllers/config_controller.dart';
import 'package:billing/models/invoice.dart';
import 'package:billing/resources/commons/common_get_snackbar.dart';
import 'package:billing/resources/widgets/pdf_body.dart';
import 'package:get/get.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class PdfServices {
  static pw.Document getPdfDoc(Invoice invoice) {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(margin: const pw.EdgeInsets.symmetric(horizontal: 20,vertical: 15), 
      clip: true,
      
        build: (context) => invoiceBodyPdf(
          invoice, // Pass unsavedInvoice instead of config
          context.page.pageFormat.width,
        ),
      ),
    );
    return pdf;
  }

  static Future<File> generatePdfInMemory(Invoice invoice) async {
    try {
      final pdf = getPdfDoc(invoice);
      final data = await pdf.save();
      final file = File(
          '${(await getTemporaryDirectory()).path}/temp_invo_${invoice.id}.pdf');
      await file.writeAsBytes(data);
      return file;
    } catch (e) {
      Get.snackbar("PDF Error", "Could not generate PDF in memory: $e");
      print(e);
      throw Exception("PDF generation failed.");
    }
  }

  //! 2. Save PDF to disk in a temporary location (user won't see it).
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
  try {
    final permission = await Permission.storage.request();
    if (!permission.isGranted) {
      CommonSnackbar.errorSnackbar("Permission Denied", "Storage access required.");
      return;
    }

    // Full directory path
    final basePath = '/storage/emulated/0/Download/Billing App';
    final dir = Directory(basePath);
    if (!await dir.exists()) await dir.create(recursive: true);

    // Ensure all folders in fileName path are created
    final filePath = '$basePath/$fileName.pdf';
    final fileDir = Directory(filePath).parent;
    if (!await fileDir.exists()) await fileDir.create(recursive: true);

    // Write PDF
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    CommonSnackbar.successSnackbar("Downloaded", "PDF saved to $filePath");
  } catch (e) {
    CommonSnackbar.errorSnackbar("PDF Error", "Failed to save PDF: $e");
    print("❌ $e");
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

  //! 5. Open the saved PDF for user to view.
  static Future<void> openPdf(File file) async =>
      await OpenFile.open(file.path);

  //? 6. Delete a PDF file (either in memory or storage).
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
