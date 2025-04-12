import 'package:billing/models/invoice.dart';
import 'package:billing/resources/commons/common_get_snackbar.dart';
import 'package:billing/resources/commons/common_spacing.dart';
import 'package:billing/resources/commons/common_text.dart';
import 'package:billing/services/pdf_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billing/controllers/storage_controller.dart';

Widget divider = const SizedBox.shrink();

class StoragePage extends StatelessWidget {
  StoragePage({super.key});

  final StorageController storage = Get.find<StorageController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Storage"),
      ),
      body: Obx(() {
        final invoices = storage.invoiceList;

        if (invoices.isEmpty) {
          return const Center(child: Text("📦 No Invoices Yet!"));
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: invoices.length,
            itemBuilder: (context, index) {
              final invoice = invoices[index];
              return GestureDetector(
                onTap: () => storage.openInvoiceById(invoice.id),
                child: customTile(index, invoice),
              );
            },
          ),
        );
      }),
    );
  }
}

Widget customTile(int index, Invoice invoice) {
  final StorageController storage = Get.find<StorageController>();
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        //h50,
        w16,
        CommonText(
          data: "${invoice.id}".padLeft(3, "0"),
          fontSize: 20,
        ),
        w10,
        //divider,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 2,
            height: 50,
            color: Colors.grey.shade300,
          ),
        ),
        w10,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(data: invoice.billTaker),
            CommonText(
              data: invoice.date,
              fontSize: 12,
              fontColor: Colors.grey,
            ),
          ],
        ),
        const Spacer(),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert),
          onSelected: (value) {
            // Handle actions here
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'open',
              onTap:()=> storage.openInvoiceById(invoice.id),
              child: Text('Open'),
            ),
            PopupMenuItem(value: 'edit', child: Text('Edit'),onTap: () =>storage.openInvoiceById(invoice.id),),
            PopupMenuItem(value: 'share', child: Text('Share'), onTap: ()=>PdfServices.sharePdfById(invoice.id),),
            PopupMenuItem(value: 'download', child: Text('Download'), onTap: ()=>PdfServices.downloadPdfById(invoice.id)),
            PopupMenuItem(value: 'delete', child: Text('Delete'), onTap: ()=>storage.deleteInvoiceById(invoice.id) ? CommonSnackbar.successSnackbar("Deleted") : CommonSnackbar.errorSnackbar("Invoice Not Deleted"),),
          ],
        ),
        w10,
      ],
    ),
  );
 
}
