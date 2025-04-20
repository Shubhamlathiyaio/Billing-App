import 'package:billing/controllers/storage_controller.dart';
import 'package:billing/models/invoice.dart';
import 'package:billing/models/invoice_item.dart';
import 'package:billing/resources/commons/common_get_snackbar.dart';
import 'package:csv/csv.dart';
import 'package:file_selector/file_selector.dart';
import 'package:get/get.dart';
import 'package:objectbox/objectbox.dart';

Future<void> importInvoicesFromCsv() async {
  // 👇 This opens the file explorer
  final XFile? file = await openFile(
    acceptedTypeGroups: [
      XTypeGroup(label: 'CSV', extensions: ['csv'])
    ],
  );

  if (file != null) {
    final csvContent = await file.readAsString();
    final rows = const CsvToListConverter().convert(csvContent);

    // Skip header (index 0)
    for (int i = 2; i < rows.length; i++) {
      print("7777777777777777777777777");
      final row = rows[i];

      final invoice = Invoice(
        companyName: row[1].toString(),
        address: row[2].toString(),
        gstNumber: row[3].toString(),
        mobileNo: row[4].toString(),
        stateCode: row[5].toString(),
        invoiceNo: row[6].toString(),
        date: row[7].toString(),
        billTaker: row[8].toString(),
        billTakerAddress: row[9].toString(),
        billTakerMobileNo: row[10].toString(),
        billTakerGSTPin: row[11].toString(),
        broker: row[12].toString(),
        bankName: row[13].toString(),
        bankBranch: row[14].toString(),
        bankAccountNo: row[15].toString(),
        bankIFSCCode: row[16].toString(),
        remark: row[17].toString(),
        discount: row[18].toString(),
        othLess: row[19].toString(),
        freight: row[20].toString(),
        iGst: row[21].toString(),
        sGst: row[22].toString(),
        cGst: row[23].toString(),
        rawItemsJson: row[24].toString(),
      );

      // Attach items from string
      invoice.items.addAll(parseItemsFromString(row[24].toString()));

      // Save in ObjectBox
      Get.find<StorageController>().saveFromFile(invoice);
    }

    CommonSnackbar.successSnackbar(
        "CSV Imported", "Invoices imported successfully.");
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
