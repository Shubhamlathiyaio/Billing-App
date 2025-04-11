import 'package:billing/controllers/config_controller.dart';
import 'package:billing/controllers/table_controller.dart';
import 'package:billing/models/invoice.dart';
import 'package:billing/models/invoice_item.dart';
import 'package:billing/objectbox.g.dart';
import 'package:billing/views/home_page.dart';
import 'package:get/get.dart';

class StorageController extends GetxController {
  final invoiceList = <Invoice>[].obs;
  final currentId = RxInt(0);

  late final Box<Invoice> _invoiceBox;

  void init(Box<Invoice> invoiceBox) {
    _invoiceBox = invoiceBox;
    loadInvoices();
    if (invoiceList.isNotEmpty) {
      currentId.value = invoiceList.last.id + 1;
    }
  }

  void loadInvoices() {
    invoiceList.value = _invoiceBox.getAll();
  }

  Invoice? get currentInvoice {
    return _invoiceBox.get(currentId.value);
  }

  Invoice? getInvoiceById(int id) {
    return _invoiceBox.get(id);
  }

  void saveInvoice(Invoice invoice) {
    final tableItems = Get.find<TableController>().itemList;
    invoice.items.addAll(tableItems.map((item) {
      final invoiceItem = InvoiceItem(
          chalan: item.chalanNo.toString(),
          itemName: item.itemName,
          quality: item.quality.toString(),
          quantity: item.quantity.toString(),
          rate: item.rate.toString());

      invoiceItem.invoice.target = invoice; // link back
      return invoiceItem;
    }));
    
    _invoiceBox.put(invoice);
    
    loadInvoices();
    currentId.value = 0;
    Get.find<NavigationController>().currentIndex.value = 3;
    print("✅ Invoice Saved in ObjectBox Dabba");
  }

  void createNewInvoice() {
    currentId.value = invoiceList.length + 1;
  }

  void openInvoiceById(int id) {
    Get.find<TableController>().itemList.clear();
    Get.find<ConfigController>().invoiceToConfig(_invoiceBox.get(id)!);
  }
}
