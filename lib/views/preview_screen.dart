import 'dart:io';

import 'package:billing/commons/common_button.dart';
import 'package:billing/services/pdf_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';
import 'package:billing/controllers/bill_controller.dart';
import 'package:printing/printing.dart';

class PreviewScreen extends StatefulWidget {
  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  late PdfController pdfController;
  final BillController controller = Get.find();

  @override
  void initState() {
    super.initState();
    pdfController = PdfController(
      document: PdfDocument.openFile(controller.pdfPath.value),
    );
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Invoice Preview")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
            decoration: BoxDecoration(border: Border.all(width: 2)),
            child: PdfView(controller: pdfController)),
      ),
      floatingActionButton: CommonButton(
          onPressed: () async {
            controller.sharePDF();
          },
          text: "Export"),
    );
  }
}
