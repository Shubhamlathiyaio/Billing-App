import 'dart:io';
import 'package:billing/controllers/config_controller.dart';
import 'package:billing/controllers/storage_controller.dart';
import 'package:billing/services/pdf_services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:billing/controllers/pdf_preview_controller.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfPreviewPage extends StatelessWidget {
  final int ?invoiceId;
  PdfPreviewPage({super.key, this.invoiceId});

  final pdfController = Get.find<PdfPreviewController>();
  final config = Get.find<ConfigController>();

  @override
  Widget build(BuildContext context) {
    pdfController.loadPdf(invoiceId); // make sure this runs only once ideally

    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
        actions: [
          IconButton(
              onPressed: () {
                PdfServices.sharePdf(pdfController.pdfFile.value!);
              },
              icon: Icon(Icons.share))
        ],
      ),
      body: Obx(() {
        if (pdfController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (pdfController.pdfFile.value != null) {
        File pdfFile = pdfController.pdfFile.value!;
          return SfPdfViewer.file(pdfFile);
        } else {return const Center(child: Text("Failed to load PDF."));}
        
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.find<StorageController>().saveInvoice(config.getInvoice());

        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
