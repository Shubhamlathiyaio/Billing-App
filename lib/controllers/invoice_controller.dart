import 'package:billing/models/invoice_item.dart';
import 'package:get/get.dart';
import 'package:billing/models/invoice.dart'; // Import Invoice model

class InvoiceController extends GetxController {
  final invoice = Invoice(
    invoiceNo: '',
    date: '',
    companyName: '',
    address: '',
    gstNumber: '',
    panNumber: '',
    stateCode: '',
    billTaker: '',
    billTakerAddress: '',
    billTakerGSTPin: '',
    userFirm: '',
    userFirmAddress: '',
    userFirmGSTPin: '',
    broker: '',
    discount: '',
    othLess: '',
    freight: '',
    iGst: '',
    sGst: '',
    cGst: '',
  ).obs;

  // Function to add InvoiceItem to the Invoice's ToMany relation
  void addItem(InvoiceItem item) {
    invoice.value.items.add(item); // Add the InvoiceItem to the ToMany relation
    update(); // Refresh the UI
  }

  // Function to get the InvoiceItems as TableItems
  RxList<TableItem> getTableItems() {
    RxList<TableItem> tableItems = RxList<TableItem>();

    // Iterating through the ToMany<InvoiceItem> and converting each to TableItem
    for (var item in invoice.value.items) {
      TableItem tableItem = TableItem(
        chalan: item.chalan,
        itemName: item.itemName,
        taka: item.taka,
        hsnCode: item.hsnCode,
        qty: item.qty,
        rate: item.rate,
      );
      tableItems.add(tableItem); // Add TableItem to list
    }

    return tableItems; // Return the RxList of TableItems for UI
  }
}

class TableItem {
  String chalan;
  String itemName;
  String taka;
  String hsnCode;
  String qty;
  String rate;

  TableItem({
    required this.chalan,
    required this.itemName,
    required this.taka,
    required this.hsnCode,
    required this.qty,
    required this.rate,
  });
}
