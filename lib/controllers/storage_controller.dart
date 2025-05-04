import 'package:billing/controllers/config_controller.dart';
import 'package:billing/controllers/pdf_preview_controller.dart';
import 'package:billing/controllers/table_controller.dart';
import 'package:billing/models/invoice.dart';
import 'package:billing/models/invoice_item.dart';
import 'package:billing/services/appStorage.dart';
import 'package:billing/views/home_page.dart';
import 'package:get/get.dart';
import 'package:objectbox/objectbox.dart';

class StorageController extends GetxController {
  final invoiceList = <Invoice>[].obs;
  late final Box<Invoice> _invoiceBox;
  Invoice unsavedInvoice = Invoice.emptyInvoice();

  void init(Box<Invoice> invoiceBox) {
    _invoiceBox = invoiceBox;
    loadInvoices();
    updateUnsavedInvoice();
    print("init of storage is called");
  }

  void loadInvoices() {
    invoiceList.value = _invoiceBox.getAll();
  }

  void updateUnsavedInvoice() {
    unsavedInvoice = _getInvoice();
    Get.find<PdfPreviewController>().pdfFile.value = null;
  }

  Invoice _getInvoice() {
    final config = Get.find<ConfigController>();
    Invoice invoice = Invoice(
      id: AppStorage.getLastInvoiceId(),
      // Company
      companyName: config.companyName,
      address: config.address,

      // Invoice
      gstNumber: config.gstNumber,
      mobileNo: config.mobileNo,
      stateCode: config.stateCode,
      invoiceNo: config.invoiceNo,
      date: config.date,

      // Billing
      billTaker: config.billTaker,
      billTakerAddress: config.billTakerAddress,
      billTakerMobileNo: config.billTakerMobileNo,
      billTakerGSTPin: config.billTakerGSTPin,
      broker: config.broker,

      // Bank details
      bankName: config.bankName,
      bankBranch: config.branchName,
      bankAccountNo: config.accountNo,
      bankIFSCCode: config.ifscCode,
      remark: config.remark,

      // Discount & Taxes
      discount: config.discount,
      othLess: config.othLess,
      freight: config.freight,
      iGst: config.iGst,
      sGst: config.sGst,
      cGst: config.cGst,
      rawItemsJson: Get.find<TableController>().rawItemsJsonFromItemList(),
    );

    invoice = addItemsIntoInvoice(invoice);
    return invoice;
  }

  Invoice addItemsIntoInvoice(Invoice invoice) {
    RxList tableItems = Get.find<TableController>().itemList;
    invoice.items.clear(); // This keeps the same ToMany object
    for (final item in tableItems) {
      final invoiceItem = InvoiceItem(
        chalan: item.chalanNo.toString(),
        itemName: item.itemName,
        taka: item.taka.toString(),
        hsnCode: item.hsnCode.toString(),
        qty: item.qty.toString(),
        rate: item.rate.toString(),
      );
      invoiceItem.invoice.target = invoice;
      invoice.items.add(invoiceItem);
    }

    return invoice;
  }

  void clearUnsavedInvoice() {
    Get.find<TableController>().itemList.clear();
    Get.find<ConfigController>().clearOtherConfigDataOnly();
    updateUnsavedInvoice();
    AppStorage.saveLastInvoiceId(0);
  }

  void saveInvoice() {
    _invoiceBox.put(unsavedInvoice);
    loadInvoices();
    AppStorage.saveLastInvoiceId(0);
  }

  void saveFromFile(Invoice invoice) {
    _invoiceBox.put(invoice);
    loadInvoices();
  }

  void clearCurrentData() {
    Get.find<TableController>().clearTable();
    Get.find<ConfigController>().clearOtherConfigDataOnly();
    updateUnsavedInvoice();
  }

  bool deleteInvoiceById(int id) {
    final deleted = _invoiceBox.remove(id);
    loadInvoices();
    return deleted;
  }

  void openInvoice(Invoice invoice) {
    //cleaning
    Get.find<TableController>().itemList.clear();
    Get.find<ConfigController>().clearOtherConfigDataOnly();

    //geting
    AppStorage.saveLastInvoiceId(invoice.id);
    Get.find<ConfigController>().invoiceToConfig(invoice);
    Get.find<TableController>()
        .setItemListFromRawItemsJson(invoice.rawItemsJson);
    // Get.find<TableController>().getTableItemsFromInvoice(invoice);

    updateUnsavedInvoice();
    Get.find<NavigationController>().changePage(1);
  }
}
