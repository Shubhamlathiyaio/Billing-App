import 'dart:io';
import 'package:billing/services/pdf_services.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFPreviewPage extends StatefulWidget {
  const PDFPreviewPage({super.key});

  @override
  State<PDFPreviewPage> createState() => _PDFPreviewPageState();
}

class _PDFPreviewPageState extends State<PDFPreviewPage> {
  File? pdfFile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  Future<void> loadPdf() async {
    final file = await PdfServices.generateInvoicePdf();
    setState(() {
      pdfFile = file;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(
        title: Text("Bill Book Is In Your Hand"),
        actions: [
          IconButton(
              onPressed: () {
                PdfServices.sharePdf(pdfFile!)  ;
              },
              icon: Icon(Icons.share))
        ],
      ),
      body: SfPdfViewer.file(pdfFile!),
    );
  }
}
