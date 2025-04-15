import 'dart:io';
import 'package:billing/controllers/invoice_controller.dart';
import 'package:billing/controllers/storage_controller.dart';
import 'package:billing/main.dart';
import 'package:billing/resources/commons/common_get_snackbar.dart';
import 'package:get/get.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:billing/controllers/config_controller.dart';
import 'package:billing/resources/widgets/pdf_body.dart';

class PdfServices {
  static pw.Document getPdfDoc(int id) {
    final config = Get.find<ConfigController>();
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) =>
            invoiceBodyPdf(config, context.page.pageFormat.width, id),
      ),
    );

    return pdf;
  }

  static Future<File> savePdf(String name, pw.Document pdf) async {
    Directory? dir;
    if (Platform.isAndroid) {
      dir = Directory('/storage/emulated/0/Download/'); // Downloads folder
    } else {
      dir = await getApplicationDocumentsDirectory(); // iOS fallback
    }

    final file = File('${dir.path}/$name');
    if (await requestPermission()) {
      await file.writeAsBytes(await pdf.save());
      return file;
    } else {
      CommonSnackbar.errorSnackbar("Show message: Permission denied");
    }
    return File("");
  }

  static Future<File?> generatePdfById(int id) async {
    try {
      final pdf = getPdfDoc(id);
      final config = Get.find<ConfigController>();
      final String name =
          "${id}_${config.billTaker}_${DateTime.now().millisecond}.pdf";
      final file = await savePdf(name, pdf);

      if (!await file.exists()) {
        throw Exception("File was not created");
      }

      return file;
    } catch (e) {
      Get.snackbar("PDF Error", "Could not generate PDF: $e");
      return null;
    }
  }

  static Future<void> sharePdfById(int id) async {
    final file = await generatePdfById(id);
    if (file == null) return;

    final title = id == 0
        ? 'Current Invoice'
        : 'Invoice #${id.toString().padLeft(3, '0')}';

    await Share.shareXFiles([XFile(file.path)], text: title);
  }

  static Future<void> downloadPdfById(int id) async {
    final invoice = Get.find<StorageController>().getInvoiceById(id);

    invoice.items
        .map((item) => TableItem(
              chalan: item.chalan,
              itemName: item.itemName,
              taka: item.taka,
              hsnCode: item.hsnCode,
              qty: item.qty,
              rate: item.rate,
            ))
        .toList();

    await PdfServices.generatePdfById(id);
  }

  static Future<void> openPdf(File file) async {
    await OpenFile.open(file.path);
  }
}
