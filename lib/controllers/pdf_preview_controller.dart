// controllers/pdf_preview_controller.dart

import 'dart:io';
import 'package:billing/controllers/config_controller.dart';
import 'package:billing/controllers/storage_controller.dart';
import 'package:get/get.dart';
import 'package:billing/services/pdf_services.dart';

class PdfPreviewController extends GetxController {
  RxBool isLoading = true.obs;
  Rx<File?> pdfFile = Rx<File?>(null);

  Future<void> loadPdf(int? invoiceID) async {
    if (invoiceID == null) {
      final storage = Get.find<StorageController>();
      Get.find<ConfigController>().invoiceToConfig(storage.getInvoiceById(invoiceID!)!);
    }
    final file = await PdfServices.generateInvoicePdf();
    pdfFile.value = file;
    isLoading.value = false;
  }
}
