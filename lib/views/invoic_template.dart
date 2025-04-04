import 'package:billing/commons/common_text.dart';
import 'package:billing/controllers/config_controller.dart';
import 'package:billing/controllers/invoice_controller.dart';
import 'package:billing/resources/media_query_helper.dart';
import 'package:billing/resources/widgets/invoice_body.dart';
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
      body: invoiceBody(context,),
      floatingActionButton: FloatingActionButton(
          onPressed: () => invoiceController.exportToPDF(),
          child: Icon(Icons.preview)),
    );
  }
}
