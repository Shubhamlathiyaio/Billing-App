import 'dart:io';

import 'package:billing/controllers/config_controller.dart';
import 'package:billing/resources/widgets/pdf_body.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

class SaveAndOpenDocument {
  static Future<File> savePdf({
    required String name,
// Document is from pdf widgets.
    required Document pdf,
  }) async {
    final root = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    final file = File('${root!.path}/$name');
    await file.writeAsBytes(await pdf.save());

    return file;
  }

  static Future<void> openPdf(File file) async {
    final path = file.path;
    await OpenFile.open(path);
  }
}

class SimplePdfApi {
  static Future<File> generateSimpleTextPdf() async {
    final configController = Get.find<ConfigController>();
    final pdf = Document();
    pdf.addPage(
      Page(
        build: (pw.Context context) =>
            invoiceBodyPdf(configController, context.page.pageFormat.width),
      ),
    );
    return SaveAndOpenDocument.savePdf(name: 'simple_pdf.pdf', pdf: pdf);
  }
}
