import 'package:billing/controllers/config_controller.dart';
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

  /// Use when opening existing invoice for edit
  // void loadInvoiceToUnsaved(Invoice selectedInvoice) {
  //   final tableCtrl = Get.find<TableController>();

  //   // Clear previous data
  //   unsavedInvoice.items.clear();
  //   tableCtrl.itemList.clear();

  //   // Copy fields manually (not whole object)
  //   unsavedInvoice
  //     ..id = selectedInvoice.id
  //     ..companyName = selectedInvoice.companyName
  //     ..address = selectedInvoice.address
  //     ..gstNumber = selectedInvoice.gstNumber
  //     ..mobileNo = selectedInvoice.mobileNo
  //     ..stateCode = selectedInvoice.stateCode
  //     ..invoiceNo = selectedInvoice.invoiceNo
  //     ..date = selectedInvoice.date
  //     ..billTaker = selectedInvoice.billTaker
  //     ..billTakerAddress = selectedInvoice.billTakerAddress
  //     ..billTakerMobileNo = selectedInvoice.billTakerMobileNo
  //     ..billTakerGSTPin = selectedInvoice.billTakerGSTPin
  //     ..broker = selectedInvoice.broker
  //     ..bankName = selectedInvoice.bankName
  //     ..bankBranch = selectedInvoice.bankBranch
  //     ..bankAccountNo = selectedInvoice.bankAccountNo
  //     ..bankIFSCCode = selectedInvoice.bankIFSCCode
  //     ..remark = selectedInvoice.remark
  //     ..discount = selectedInvoice.discount
  //     ..othLess = selectedInvoice.othLess
  //     ..freight = selectedInvoice.freight
  //     ..iGst = selectedInvoice.iGst
  //     ..sGst = selectedInvoice.sGst
  //     ..cGst = selectedInvoice.cGst;

  //   AppStorage.saveLastInvoiceId(unsavedInvoice.id);

  //   for (final item in selectedInvoice.items) {
  //     final copiedItem = item.copyWith();
  //     copiedItem.invoice.target = unsavedInvoice;
  //     unsavedInvoice.items.add(copiedItem);
  //   }

  //   print("Items count: ${unsavedInvoice.items.length}");
  //   print("Invoice ID: ${unsavedInvoice.id}");
  // }

  void updateUnsavedInvoice() {
    unsavedInvoice = _getInvoice();
    // unsavedInvoice.items.applyToDb();
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
      // panNumber: config.panNumber,
      stateCode: config.stateCode,
      invoiceNo: config.invoiceNo,
      date: config.date,

      // Billing
      billTaker: config.billTaker,
      billTakerAddress: config.billTakerAddress,
      billTakerMobileNo: config.billTakerMobileNo,
      billTakerGSTPin: config.billTakerGSTPin,
      // deliveryFirm: config.deliveryFirm,
      // deliveryFirmAddress: config.deliveryFirmAddress,
      // deliveryFirmMobileNo: config.deliveryFirmMobileNo,
      // deliveryFirmGSTPin: config.deliveryFirmGSTPin,
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
