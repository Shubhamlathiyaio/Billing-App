import 'package:billing/models/invoice.dart';
import 'package:billing/resources/commons/common_get_snackbar.dart';
import 'package:billing/resources/commons/common_spacing.dart';
import 'package:billing/resources/commons/common_text.dart';
import 'package:billing/services/pdf_services.dart';
import 'package:billing/services/small_services.dart';
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
        // List<Invoice> temp = [for(var e in storage.invoiceList)e];
        // final List<String> t = [for (Invoice e in temp) e.invoiceNo];
        // t.sort();
        // print(t);

        List<Invoice> invos = [for (Invoice e in storage.invoiceList) e];
        // for (String i in t) {
        //   print("Times");
        //   invos.add(temp.removeAt(temp.indexWhere((e) {
        //     print(e.invoiceNo);
        //     print(i);
        //     return e.invoiceNo == i;
        //   })));
        // }
        // print(invos.first.invoiceNo);
        // print(invos.last.invoiceNo);

        invos.sort((a, b) {
          final aNum = int.tryParse(a.invoiceNo) ?? 0;
          final bNum = int.tryParse(b.invoiceNo) ?? 0;
          return aNum.compareTo(bNum);
        });
        print("strat");
        for (Invoice e in invos) print("INvoi = ${e.invoiceNo}");

        final invoices = invos;

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
                onTap: () => storage.openInvoice(invoice),
                child: customTile(invoice),
              );
            },
          ),
        );
      }),
    );
  }
}

Widget customTile(Invoice invoice) {
  final StorageController storage = Get.find<StorageController>();
  print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
  print("${invoice.id} = ${invoice.items.length}");
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        w16,
        CommonText(
          data: invoice.invoiceNo.padLeft(3, "0"),
          fontSize: 20,
        ),
        w10,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 2,
            height: 50,
            color: Colors.grey.shade300,
          ),
        ),
        w10,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                invoice.billTaker,
                overflow: TextOverflow.ellipsis,
              ),
              CommonText(
                data: invoice.date,
                fontSize: 12,
                fontColor: Colors.grey,
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert),
          onSelected: (value) async {
            if (value == 'share') {
              final pdf = PdfServices.getPdfDoc(invoice);
              await PdfServices.sharePdf(pdf, getFileName(invoice.id));
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'open',
              onTap: () => storage.openInvoice(invoice),
              child: Text('Open'),
            ),
            PopupMenuItem(
              value: 'edit',
              child: Text('Edit'),
              onTap: () => storage.openInvoice(invoice),
            ),
            PopupMenuItem(
                value: 'share',
                child: Text('Share'),
                onTap: () {
                  Invoice unsavedInvoice =
                      Get.find<StorageController>().unsavedInvoice;
                  PdfServices.sharePdf(PdfServices.getPdfDoc(invoice),
                          getFileName(invoice.id))
                      .then(
                    (value) {
                      storage.openInvoice(unsavedInvoice);
                    },
                  );
                }),
            PopupMenuItem(
              value: 'download',
              child: Text('Download'),
              onTap: () {
                Get.find<StorageController>().saveInvoice();
                PdfServices.downloadPdf(
                    PdfServices.getPdfDoc(invoice), getFileName(invoice.id));
              },
            ),
            PopupMenuItem(
              value: 'delete',
              child: Text('Delete'),
              onTap: () {
                final deleted = storage.deleteInvoiceById(invoice.id);
                deleted
                    ? CommonSnackbar.customSuccessSnackbar("Deleted")
                    : CommonSnackbar.errorSnackbar("Invoice Not Deleted");
              },
            ),
          ],
        ),
        w10,
      ],
    ),
  );
}
