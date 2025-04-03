import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:billing/services/pdf_services.dart';
import 'dart:io';

class BillController extends GetxController {
  var itemController = TextEditingController();
  var priceController = TextEditingController();
  var pdfPath = "".obs; // Stores the generated PDF path

  /// Exports PDF and stores the path for preview
  Future<void> exportToPDF() async {
    final pdfFile = await PDFServices.generatePDF(
      itemController.text,
      priceController.text,
    );
    pdfPath.value = pdfFile.path; // Save path for preview
    goToPreview();
  }

  /// Shares the generated PDF
  Future<void> sharePDF() async {
    if (pdfPath.isNotEmpty && File(pdfPath.value).existsSync()) {
      await PDFServices.sharePDF(pdfPath.value);
    } else {
      Get.snackbar("Error", "Please export the PDF first!",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// Navigates to the preview screen
  void goToPreview() {
    if (pdfPath.value.isNotEmpty) {
      Get.toNamed('/preview');
    }
  }
}
