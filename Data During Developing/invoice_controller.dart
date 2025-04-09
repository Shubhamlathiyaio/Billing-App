import 'dart:io';

import 'package:billing/services/pdf_services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class InvoiceController extends GetxController {
  var invoiceNo = "".obs;
  var date = "".obs;
  var challanNo = "".obs;
  var billTaker = "".obs;
  var billTakerAddress = "".obs;
  var billTakerMoNo = "".obs;
  var billTakerGstNo = "".obs;
  var userFirm = "".obs;
  var userFirmAddress = "".obs;
  var userFirmGstNo = "".obs;
  var broker = "".obs;
  var items = <InvoiceItem>[].obs;
  var remarks = "".obs;
  var discount = "".obs;
  var otherLess = "".obs;
  var freight = "".obs;
  var taxableValue = "".obs;
  var iGst = "".obs;
  var sGst = "".obs;
  var cGst = "".obs;
  var dueDays = "".obs;
  var dueDate = "".obs;
  var netAmount = "".obs;
  var finalTotal = "".obs;
  var amountInWords = "".obs;
  var terms = "".obs;
  var pdfPath = "".obs; // Stores the generated PDF path

  /// Generates and stores PDF for preview
  Future<void> exportToPDF(BuildContext context) async {
  final pdfFile = await PDFServices.generatePDF(context);
  pdfPath.value = pdfFile.path; // Save for preview
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

  /// Navigates to preview page
  void goToPreview() {
    Get.toNamed('/preview');
  }

}

class InvoiceItem {
  final String srNo;
  final String description;
  final String quality;
  final String hsnCode;
  final String qty;
  final String rate;
  final String amount;

  InvoiceItem({
    required this.srNo,
    required this.description,
    required this.quality,
    required this.hsnCode,
    required this.qty,
    required this.rate,
    required this.amount,
  });
}
