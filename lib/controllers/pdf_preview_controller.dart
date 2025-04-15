// controllers/pdf_preview_controller.dart

import 'dart:io';
import 'package:billing/controllers/storage_controller.dart';
import 'package:get/get.dart';
import 'package:billing/services/pdf_services.dart';
import 'package:path_provider/path_provider.dart';

class PdfPreviewController extends GetxController {
  RxBool isLoading = true.obs;
  Rx<File?> pdfFile = Rx<File?>(null);

  Future<void> generatePdfForDownload() async {
    // if (pdfFile.value != null) {await pdfFile.value!.delete();}
    final pdf =
        PdfServices.getPdfDoc(Get.find<StorageController>().currentId.value);
    final bytes = await pdf.save();

    final dir = await getDownloadsDirectory();
    final file = File(
        "${dir!.path}/invoice_${DateTime.now().millisecondsSinceEpoch}.pdf");
    await file.writeAsBytes(bytes);

    pdfFile.value = file;
    isLoading.value = false;
  }
}
