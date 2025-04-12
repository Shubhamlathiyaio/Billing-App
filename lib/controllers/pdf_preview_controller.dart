// controllers/pdf_preview_controller.dart

import 'dart:io';
import 'package:billing/controllers/storage_controller.dart';
import 'package:get/get.dart';
import 'package:billing/services/pdf_services.dart';

class PdfPreviewController extends GetxController {
  RxBool isLoading = true.obs;
  Rx<File?> pdfFile = Rx<File?>(null);

  Future<void> loadPdf() async {
    final file = await PdfServices.generatePdfById(Get.find<StorageController>().currentId.value);
    pdfFile.value = file;
    isLoading.value = false;
  }
}
