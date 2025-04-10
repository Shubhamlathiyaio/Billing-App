

import 'package:billing/models/invoice.dart';
import 'package:billing/objectbox.g.dart';
import 'package:billing/views/home_page.dart';
import 'package:get/get.dart';

class StorageController extends GetxController {
  final invoiceList = <Invoice>[].obs;

  late final Box<Invoice> _invoiceBox;

  void init(Box<Invoice> invoiceBox) {
    _invoiceBox = invoiceBox;
    loadInvoices();
  }

  void loadInvoices() {
    invoiceList.value = _invoiceBox.getAll();
  }

Invoice? getInvoiceById(int id) {
  return _invoiceBox.get(id);
}

  void saveInvoice(Invoice invoice) {
  _invoiceBox.put(invoice); // put() adds or updates based on `id`
  loadInvoices();
  Get.find<NavigationController>().currentIndex.value = 3; 
  print("✅ Invoice Saved in ObjectBox Dabba");
}

}
