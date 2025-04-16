import 'package:billing/controllers/storage_controller.dart';
import 'package:get/get.dart';
import 'package:objectbox/objectbox.dart';
import 'package:billing/models/invoice_item.dart'; // Import the InvoiceItem model

@Entity()
class Invoice {
  int id = Get.find<StorageController>().currentId.value; // Unique ID (auto-incremented)

  // All fields are stored as String
  String companyName;
  String address;
  String mobileNo;
  String gstNumber;
  String panNumber;
  String stateCode;
  String invoiceNo;
  String date;
  String billTaker;
  String billTakerAddress;
  String billTakerMobileNo;
  String billTakerGSTPin;
  String deliveryFirm;
  String deliveryFirmAddress;
  String deliveryFirmMobileNo;
  String deliveryFirmGSTPin;
  String broker;
  String bankName;
  String bankBranch;
  String bankAccountNo;
  String bankIFSCCode;
  String remark;
  String discount;
  String othLess;
  String freight;
  String iGst;
  String sGst;
  String cGst;

  @Backlink()
  final items = ToMany<InvoiceItem>(); // ToMany relation to InvoiceItem

  Invoice({
    this.id = 0,
    required this.companyName,
    required this.address,
    required this.mobileNo,
    required this.gstNumber,
    required this.panNumber,
    required this.stateCode,
    required this.invoiceNo,
    required this.date,
    required this.billTaker,
    required this.billTakerAddress,
    required this.billTakerMobileNo,
    required this.billTakerGSTPin,
    required this.deliveryFirm,
    required this.deliveryFirmAddress,
    required this.deliveryFirmMobileNo,
    required this.deliveryFirmGSTPin,
    required this.broker,
    required this.bankName,
    required this.bankBranch,
    required this.bankAccountNo,
    required this.bankIFSCCode,
    required this.remark,
    required this.discount,
    required this.othLess,
    required this.freight,
    required this.iGst,
    required this.sGst,
    required this.cGst,
  });

  // Method to copy the current Invoice instance (useful if needed)
  Invoice copy() {
    return Invoice(
      id: this.id,
      companyName: companyName,
      address: address,
      mobileNo: mobileNo,
      gstNumber: gstNumber,
      panNumber: panNumber,
      stateCode: stateCode,
      invoiceNo: invoiceNo,
      date: date,
      billTaker: billTaker,
      billTakerAddress: billTakerAddress,
      billTakerMobileNo: billTakerMobileNo,    
      billTakerGSTPin: billTakerGSTPin,
      deliveryFirm: deliveryFirm,
      deliveryFirmAddress: deliveryFirmAddress,
      deliveryFirmMobileNo: deliveryFirmMobileNo,
      deliveryFirmGSTPin: deliveryFirmGSTPin,
      broker: broker,
      bankName: bankName,
      bankBranch: bankBranch,
      bankAccountNo: bankAccountNo,
      bankIFSCCode: bankIFSCCode,
      remark: remark,
      discount: discount,
      othLess: othLess,
      freight: freight,
      iGst: iGst,
      sGst: sGst,
      cGst: cGst,
      
    );
  }

  // Convert the Invoice to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyName': companyName,
      'address': address,
      'mobileNo': mobileNo,
      'gstNumber': gstNumber,
      'panNumber': panNumber,
      'stateCode': stateCode,
      'invoiceNo': invoiceNo,
      'date': date,
      'billTaker': billTaker,
      'billTakerAddress': billTakerAddress,
      'billTakerMobileNo': billTakerMobileNo,
      'billTakerGSTPin': billTakerGSTPin,
      'deliveryFirm': deliveryFirm,
      'deliveryFirmAddress': deliveryFirmAddress,
      'deliveryFirmMobileNo': deliveryFirmMobileNo,
      'deliveryFirmGSTPin': deliveryFirmGSTPin,
      'broker': broker,
      'bankName': bankName,
      'bankBranch': bankBranch,
      'bankAccountNo': bankAccountNo,
      'bankIFSCCode': bankIFSCCode,
      'remark': remark,
      'discount': discount,
      'othLess': othLess,
      'freight': freight,
      'iGst': iGst,
      'sGst': sGst,
      'cGst': cGst,
    };
  }

  // Static method to create an empty Invoice instance
  static Invoice emptyInvoice() {
    return Invoice(
      companyName: '',
      address: '',
      mobileNo: '',
      gstNumber: '',
      panNumber: '',
      stateCode: '',
      invoiceNo: '',
      date: '',
      billTaker: '',
      billTakerAddress: '',
      billTakerMobileNo: '',
      billTakerGSTPin: '',
      deliveryFirm: '',
      deliveryFirmAddress: '',
      deliveryFirmMobileNo: '',
      deliveryFirmGSTPin: '',
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
    );
  }
}
