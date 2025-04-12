import 'package:billing/controllers/storage_controller.dart';
import 'package:get/get.dart';
import 'package:objectbox/objectbox.dart';
import 'package:billing/models/invoice_item.dart'; // Import the InvoiceItem model

@Entity()
class Invoice {
  int id = Get.find<StorageController>()
      .currentId
      .value; // Unique ID (auto-incremented)

  // All fields are stored as String
  String invoiceNo;
  String date;
  String companyName;
  String address;
  String gstNumber;
  String panNumber;
  String stateCode;
  String billTaker;
  String billTakerAddress;
  String billTakerGSTPin;
  String userFirm;
  String userFirmAddress;
  String userFirmGSTPin;
  String broker;
  String discount;
  String othLess;
  String freight;
  String iGst;
  String sGst;
  String cGst;

  @Backlink()
  final items = ToMany<InvoiceItem>(); // ToMany relation to InvoiceItem

  Invoice({
    required this.invoiceNo,
    required this.date,
    required this.companyName,
    required this.address,
    required this.gstNumber,
    required this.panNumber,
    required this.stateCode,
    required this.billTaker,
    required this.billTakerAddress,
    required this.billTakerGSTPin,
    required this.userFirm,
    required this.userFirmAddress,
    required this.userFirmGSTPin,
    required this.broker,
    required this.discount,
    required this.othLess,
    required this.freight,
    required this.iGst,
    required this.sGst,
    required this.cGst,
  });

  // Method to copy the current Invoice instance (useful if needed)
  copy() {
    return Invoice(
      invoiceNo: invoiceNo,
      date: date,
      companyName: companyName,
      address: address,
      gstNumber: gstNumber,
      panNumber: panNumber,
      stateCode: stateCode,
      billTaker: billTaker,
      billTakerAddress: billTakerAddress,
      billTakerGSTPin: billTakerGSTPin,
      userFirm: userFirm,
      userFirmAddress: userFirmAddress,
      userFirmGSTPin: userFirmGSTPin,
      broker: broker,
      discount: discount,
      othLess: othLess,
      freight: freight,
      iGst: iGst,
      sGst: sGst,
      cGst: cGst,
    );
  }

  // Convert the Invoice to JSON (if needed)
  toJson() {
    return {
      'invoiceNo': invoiceNo,
      'date': date,
      'companyName': companyName,
      'address': address,
      'gstNumber': gstNumber,
      'panNumber': panNumber,
      'stateCode': stateCode,
      'billTaker': billTaker,
      'billTakerAddress': billTakerAddress,
      'billTakerGSTPin': billTakerGSTPin,
      'userFirm': userFirm,
      'userFirmAddress': userFirmAddress,
      'userFirmGSTPin': userFirmGSTPin,
      'broker': broker,
      'discount': discount,
      'othLess': othLess,
      'freight': freight,
      'iGst': iGst,
      'sGst': sGst,
      'cGst': cGst,
    };
  }
}


Invoice emptyInvoice() {
  return Invoice(
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
  );
}
