import 'dart:io';
import 'package:billing/controllers/config_controller.dart';
import 'package:billing/resources/keep_button.dart';
import 'package:billing/views/home_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:billing/controllers/pdf_preview_controller.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfPreviewPage extends StatelessWidget {
  PdfPreviewPage({super.key});

  final pdfController = Get.find<PdfPreviewController>();
  final config = Get.find<ConfigController>();

  @override
  Widget build(BuildContext context) {
    pdfController.generatePdfForView();

    return Scaffold(
      drawer: Drawer(
        child: buildAppDrawer(context),
      ),
      appBar: AppBar(title: const Text('PDF Preview')),
      body: Obx(() {
        if (pdfController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (pdfController.pdfFile.value != null) {
          File pdfFile = pdfController.pdfFile.value!;
          return SfPdfViewer.file(pdfFile);
        } else {
          return const Center(child: Text("Failed to load PDF."));
        }
      }),
      floatingActionButton: KeepStyleFAB(),
    );
  }
}