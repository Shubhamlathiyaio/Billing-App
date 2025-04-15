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
      currentId.value = 0;
    }
  }

  void loadInvoices() {
    invoiceList.value = _invoiceBox.getAll();
  }

  Invoice? get currentInvoice {
    if (currentId.value > 0) {
      return _invoiceBox.get(currentId.value);
    }
    return null;
  }

  Invoice getInvoiceById(int id) {
    if (id <= 0) return emptyInvoice();
    return _invoiceBox.get(id) ?? emptyInvoice();
  }

  void saveInvoice(Invoice invoice) {
    invoice.id = Get.find<StorageController>().currentId.value;
    final tableItems = Get.find<TableController>().itemList;
    invoice.items.clear(); // Clear existing items
    print(invoice.items.length);
    invoice.items.addAll(tableItems.map((item) {
      final invoiceItem = InvoiceItem(
          chalan: item.chalanNo.toString(),
          itemName: item.itemName,
          taka: item.taka.toString(),
          hsnCode: item.hsnCode.toString(),
          qty: item.qty.toString(),
          rate: item.rate.toString());

      invoiceItem.invoice.target = invoice; // link back
      return invoiceItem;
    }));

    print(invoice.items.length);
    if(invoice.id!=0)_invoiceBox.remove(invoice.id); // Remove existing invoice if any
    _invoiceBox.put(invoice);

    print(_invoiceBox.get(invoice.id)?.items.length);

    loadInvoices();
    currentId.value = 0;
    Get.find<NavigationController>().currentIndex.value = 3;
    print("✅ Invoice Saved in ObjectBox Dabba");
  }

  void openInvoiceById(int id) {
    Get.find<TableController>().itemList.clear();
    currentId.value = id;
    Get.find<ConfigController>().invoiceToConfig(_invoiceBox.get(id)!);
    Get.find<NavigationController>().changePage(1);
  }

  bool deleteInvoiceById(int id) {
    bool b = _invoiceBox.remove(id);
    loadInvoices();
    return b;
  }
}
