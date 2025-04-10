import 'package:billing/resources/commons/common_spacing.dart';
import 'package:billing/views/pdf_preview_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billing/controllers/storage_controller.dart';

class StoragePage extends StatelessWidget {
  StoragePage({super.key});

  final StorageController controller = Get.find<StorageController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final invoices = controller.invoiceList;

      if (invoices.isEmpty) {
        return const Center(child: Text("📦 No Invoices Yet!"));
      }

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: invoices.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (_, index) {
            final invoice = invoices[index];
            return GestureDetector(
               onTap: () {
    Get.to(() => PdfPreviewPage(invoiceId: invoice.id));
  },
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(invoice.invoiceNo,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      h10,
                      Text(invoice.invoiceNo),
                      h10,
                      Text(invoice.date),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
