// controllers/pdf_preview_controller.dart
import 'dart:io';
import 'package:billing/controllers/storage_controller.dart';
import 'package:get/get.dart';
import 'package:billing/services/pdf_services.dart';

class PdfPreviewController extends GetxController {
  RxBool isLoading = true.obs;
  Rx<File?> pdfFile = Rx<File?>(null);

  Future<void> generatePdfForView() async {
    isLoading.value = true;

    Get.find<StorageController>().updateUnsavedInvoice();
    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    print(Get.find<StorageController>().unsavedInvoice.companyName);
    // Generate PDF in memory (user can't see the file)
    final file = await PdfServices.generatePdfInMemory(
        Get.find<StorageController>().unsavedInvoice);

    pdfFile.value = file;
    isLoading.value = false;
  }
}
