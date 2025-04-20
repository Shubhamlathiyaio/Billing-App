import 'package:billing/services/small_services.dart';
import 'package:get/get.dart';
import 'package:billing/models/invoice.dart'; // Import Invoice model

class InvoiceController extends GetxController {
  final invoice = Invoice(
    companyName: '',
    address: '',
    gstNumber: '',
    mobileNo: '',
    // panNumber: '',
    stateCode: '24',
    invoiceNo: '',
    date: getDate(DateTime.now()),
    billTaker: '',
    billTakerAddress: '',
    billTakerMobileNo: '',
    billTakerGSTPin: '',
    // deliveryFirm: '',
    // deliveryFirmAddress: '',
    // deliveryFirmMobileNo: '',
    // deliveryFirmGSTPin: '',
    broker: '',
    bankName: '',
    bankBranch: '',
    bankAccountNo: '',
    bankIFSCCode: '',
    remark: '',
    discount: '',
    othLess: '',
    freight: '',
    iGst: '',
    sGst: '',
    cGst: '',
    rawItemsJson: '',
  ).obs;

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
