import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import '../controllers/invoice_controller.dart';

class PreviewPage extends StatelessWidget {
  final InvoiceController invoiceController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PDF Preview")),
      body: Obx(() {
        if (invoiceController.pdfPath.value.isEmpty)
          return Center(child: Text("No PDF Generated!"));

        return PDFView(
          filePath: invoiceController.pdfPath.value,
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          invoiceController.sharePDF();
        },
        child: Icon(Icons.share),
      ),
    );
  }
}
