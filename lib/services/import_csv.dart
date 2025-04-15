import 'package:billing/controllers/storage_controller.dart';
import 'package:billing/models/invoice.dart';
import 'package:billing/models/invoice_item.dart';
import 'package:billing/objectbox.g.dart';
import 'package:billing/resources/commons/common_get_snackbar.dart';
import 'package:csv/csv.dart';
import 'package:file_selector/file_selector.dart';
import 'package:get/get.dart';
Future<void> importInvoicesFromCsv() async {
  // 👇 This opens the file explorer
  final XFile? file = await openFile(
  acceptedTypeGroups: [XTypeGroup(label: 'CSV', extensions: ['csv'])],
);

if (file != null) {
  final csvContent = await file.readAsString();
  final rows = const CsvToListConverter().convert(csvContent);


    // Skip header (index 0)
    for (int i = 2; i < rows.length; i++) {
      final row = rows[i];

      final invoice = Invoice(
        companyName: row[1].toString(),
        address: row[2].toString(),
        mobileNo: row[3].toString(),
        gstNumber: row[4].toString(),
        panNumber: row[5].toString(),
        stateCode: row[6].toString(),
        invoiceNo: row[7].toString(),
        date: row[8].toString(),
        billTaker: row[9].toString(),
        billTakerAddress: row[10].toString(),
        billTakerMobileNo: row[11].toString(),
        billTakerGSTPin: row[12].toString(),
        deliveryFirm: row[13].toString(),
        deliveryFirmAddress: row[14].toString(),
        deliveryFirmMobileNo: row[15].toString(),
        deliveryFirmGSTPin: row[16].toString(),
        broker: row[17].toString(),
        bankName: row[18].toString(),
        bankBranch: row[19].toString(),
        bankAccountNo: row[20].toString(),
        bankIFSCCode: row[21].toString(),
        remark: row[22].toString(),
        discount: row[23].toString(),
        othLess: row[24].toString(),
        freight: row[25].toString(),
        iGst: row[26].toString(),
        sGst: row[27].toString(),
        cGst: row[28].toString(),
      );

      // Attach items from string
      invoice.items.addAll(parseItemsFromString(row[29].toString()));

      // Save in ObjectBox
      Get.find<StorageController>().saveInvoice(invoice);
    }

    CommonSnackbar.successSnackbar("CSV Imported", "Invoices imported successfully.");
  } else {
    CommonSnackbar.errorSnackbar("No file selected.");
  }
}

ToMany<InvoiceItem> parseItemsFromString(String value) {
  final items = ToMany<InvoiceItem>();

  if (value.isEmpty) return items;

  for (var itemStr in value.split('|')) {
    final parts = itemStr.split(':');
    if (parts.length < 6) continue;

    final item = InvoiceItem(
      chalan: parts[0],
      itemName: parts[1],
      taka: parts[2],
      hsnCode: parts[3],
      qty: parts[4],
      rate: parts[5],
    );

    items.add(item);
  }

  return items;
}