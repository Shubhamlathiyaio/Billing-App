// controllers/pdf_preview_controller.dart

import 'dart:io';
import 'package:get/get.dart';
import 'package:billing/services/pdf_services.dart';

class PdfPreviewController extends GetxController {
  RxBool isLoading = true.obs;
  Rx<File?> pdfFile = Rx<File?>(null);

  Future<void> loadPdf() async {
    final file = await PdfServices.generateInvoicePdf();
    pdfFile.value = file;
    isLoading.value = false;
  }
}
