import 'dart:io';
import 'package:billing/controllers/config_controller.dart';
import 'package:billing/controllers/storage_controller.dart';
import 'package:billing/resources/commons/common_chip.dart';
import 'package:billing/resources/commons/common_text.dart';
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
          return Stack(
            children: [
              SfPdfViewer.file(pdfFile),
              Positioned(
                left: 15,
                top: 55,
                child: CommonChip(
                  verticalPadding: 0,
                  iconSize: 21,
                  alignment: Alignment.center,
                  backgroundColor: Theme.of(context).primaryColor,
                  icon: Icons.receipt_long,
                  height: 40,
                  width: 100,
                  radius: 5,
                  child: CommonText(
                      fontColor: Colors.white,
                      fontSize: 21,
                      data: "${Get.find<StorageController>().currentId.value}"
                          .padLeft(3, '0')),
                ),
              ),
            ],
          );
        } else {
          return const Center(child: Text("Failed to load PDF."));
        }
      }),
      floatingActionButton: KeepStyleFAB(),
    );
  }
}