import 'package:billing/controllers/config_controller.dart';
import 'package:billing/models/invoice.dart';
import 'package:billing/resources/commons/common_text.dart';
import 'package:billing/views/home_page.dart';
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
            childAspectRatio: 1 / 1.41, // A4 size ratio (approx 210:297)
          ),
          itemBuilder: (_, index) {
            final invoice = invoices[index];
            return GestureDetector(
              onTap: () {
                Get.find<StorageController>().openInvoiceById(invoice.id);
                Get.find<NavigationController>().changePage(1);
              },
              child: customCard(context, invoice),
            );
          },
        ),
      );
    });
  }
}

Widget customCard(BuildContext context, Invoice invoice) {
  return AspectRatio(
    aspectRatio: 1 / 1.41, // A4 ratio
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade400, width: 1.5),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top: File Icon and Invoice ID
            Row(
              children: [
                const Icon(Icons.picture_as_pdf, color: Colors.redAccent),
                const SizedBox(width: 8),
                CommonText(
                  data: "${invoice.id}",
                  fontSize: 20,
                  fontColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
            const Divider(height: 20, thickness: 1),
            // Main Info
            CommonText(
              data: "👤 ${invoice.billTaker}",
            ),
            const SizedBox(height: 8),
            CommonText(
              data: "📅 ${invoice.date}",
            ),
            const Spacer(),
            // Footer
            Align(
              alignment: Alignment.bottomRight,
              child: CommonText(
                data: "Tap to open PDF",
                fontSize: 12,
                fontColor: Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
