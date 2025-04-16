import 'package:billing/controllers/config_controller.dart';
import 'package:billing/controllers/table_controller.dart';
import 'package:billing/models/invoice.dart';
import 'package:billing/models/invoice_item.dart';
import 'package:billing/objectbox.g.dart';
import 'package:billing/resources/commons/common_get_snackbar.dart';
import 'package:billing/views/home_page.dart';
import 'package:get/get.dart';

class StorageController extends GetxController {
  final invoiceList = <Invoice>[].obs;
  final currentId = RxInt(0);

  late final Box<Invoice> _invoiceBox;

  /// This is the live invoice used for preview, form, editing
  late Invoice unsavedInvoice;

  void init(Box<Invoice> invoiceBox) {
    _invoiceBox = invoiceBox;
    loadInvoices();
    unsavedInvoice = _buildUnsavedInvoice(); // initial value
  }

  void loadInvoices() => invoiceList.value = _invoiceBox.getAll();
  

  Invoice? get currentInvoice {
    if (currentId.value > 0) {
      return _invoiceBox.get(currentId.value);
    }
    return null;
  }

  Invoice getInvoiceById(int id) {
    if (id <= 0) return Invoice.emptyInvoice();
    return _invoiceBox.get(id) ?? Invoice.emptyInvoice();
  }

  /// Use when opening existing invoice for edit
 void loadInvoiceToUnsaved(Invoice selectedInvoice) {
  unsavedInvoice = selectedInvoice.copy(); // copy base fields

  unsavedInvoice.items.clear();
  for (final item in selectedInvoice.items) {
    final copiedItem = item.copyWith(); // or create new instance
    copiedItem.invoice.target = unsavedInvoice;
    unsavedInvoice.items.add(copiedItem);
  }
}


  /// Build live invoice from config + table
  Invoice _buildUnsavedInvoice() {
    final config = Get.find<ConfigController>();
    final tableItems = Get.find<TableController>().itemList;

    final invoice = config.getInvoice();

    invoice.items.addAll(tableItems.map((item) {
      final invoiceItem = InvoiceItem(
        chalan: item.chalanNo.toString(),
        itemName: item.itemName,
        taka: item.taka.toString(),
        hsnCode: item.hsnCode.toString(),
        qty: item.qty.toString(),
        rate: item.rate.toString(),
      );
      invoiceItem.invoice.target = invoice;
      return invoiceItem;
    }));

    return invoice;
  }

  void updateUnsavedInvoice() {
    unsavedInvoice = _buildUnsavedInvoice();
  }

  void clearUnsavedInvoice() {
    unsavedInvoice = Invoice.emptyInvoice(); // resets
    Get.find<TableController>().itemList.clear();
  }

  void saveInvoice() {
    final invoice = unsavedInvoice;

    if (invoice.id == 0) {
      invoice.id = _invoiceBox.getAll().length + 1;
    } else {
      _invoiceBox.remove(invoice.id);
    }

    _invoiceBox.put(invoice);
    loadInvoices();

    clearUnsavedInvoice();
    currentId.value = 0;

    Get.find<NavigationController>().changePage(3);
    CommonSnackbar.customSuccessSnackbar("Saved");
  }

  bool deleteInvoiceById(int id) {
    final deleted = _invoiceBox.remove(id);
    loadInvoices();
    return deleted;
  }

  void openInvoiceById(int id) {
    final invoice = _invoiceBox.get(id);
    if (invoice != null) {
      Get.find<TableController>().itemList.clear();
      currentId.value = id;
      Get.find<ConfigController>().invoiceToConfig(invoice);
      loadInvoiceToUnsaved(invoice);
      Get.find<NavigationController>().changePage(1);
    }
  }
}
