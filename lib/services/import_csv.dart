import 'package:billing/controllers/storage_controller.dart';
import 'package:billing/models/invoice.dart';
import 'package:billing/resources/commons/common_get_snackbar.dart';
import 'package:csv/csv.dart';
import 'package:file_selector/file_selector.dart';
import 'package:get/get.dart';

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
      final row = rows[i];
      final invoice = Invoice(
        id: 0,
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

      Get.find<StorageController>().saveFromFile(invoice);
    }

    CommonSnackbar.successSnackbar(
        "CSV Imported", "Invoices imported successfully.");
  } else {
    CommonSnackbar.errorSnackbar("No file selected.");
  }
}
