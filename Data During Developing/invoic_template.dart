import 'package:billing/commons/common_button.dart';
import 'package:billing/commons/common_text.dart';
import 'package:billing/controllers/config_controller.dart';
import 'invoice_controller.dart';
import 'package:billing/resources/media_query_helper.dart';
import 'invoice_body.dart';
import 'package:billing/resources/widgets/show_item_input_dialog.dart';
import 'package:billing/services/save_and_open.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceTemplate extends StatelessWidget {
  InvoiceTemplate({super.key});

  final configController = Get.find<ConfigController>();
  final invoiceController = Get.find<InvoiceController>();

  @override
  Widget build(BuildContext context) {
    final media = MediaQueryHelper(context);
    double baseFontSize = media.screenWidth * 0.017; // Updated base font size

    return Scaffold(
      appBar: AppBar(
        title: CommonText(data: "Billing"),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/config');
            },
            icon: Icon(Icons.settings), // Updated icon
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          
          children: [
            invoiceBody(
              context,
            ),
            CommonButton(
              text: "Preview",
              onPressed: () async {
                final simplePdfFile = await SimplePdfApi.generateSimpleTextPdf();
                SaveAndOpenDocument.openPdf(simplePdfFile);
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showItemInputDialog();

  final simplePdfFile = await SimplePdfApi.generateSimpleTextPdf();
                SaveAndOpenDocument.openPdf(simplePdfFile);

          },
          child: Icon(Icons.preview)),
    );
  }
}
