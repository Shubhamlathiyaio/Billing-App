import 'package:billing/services/small_services.dart';
import 'package:objectbox/objectbox.dart';
import 'package:billing/models/invoice_item.dart'; // Import the InvoiceItem model
import 'package:billing/objectbox.g.dart';

@Entity()
class Invoice {
  @Id()
  int id = 0;
  // All fields are stored as String
  String companyName;
  String address;
  String gstNumber;
  String mobileNo;
  // String panNumber;
  String stateCode;
  String invoiceNo;
  String date;
  String billTaker;
  String billTakerAddress;
  String billTakerMobileNo;
  String billTakerGSTPin;
  // String deliveryFirm;
  // String deliveryFirmAddress;
  // String deliveryFirmMobileNo;
  // String deliveryFirmGSTPin;
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

  @Property()
  String rawItemsJson;

  @Backlink()
  final items = ToMany<InvoiceItem>(); // ToMany relation to InvoiceItem

  Invoice({
    this.id = 0,
    required this.companyName,
    required this.address,
    required this.gstNumber,
    required this.mobileNo,
    // required this.panNumber,
    required this.stateCode,
    required this.invoiceNo,
    required this.date,
    required this.billTaker,
    required this.billTakerAddress,
    required this.billTakerMobileNo,
    required this.billTakerGSTPin,
    // required this.deliveryFirm,
    // required this.deliveryFirmAddress,
    // required this.deliveryFirmMobileNo,
    // required this.deliveryFirmGSTPin,
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
    required this.rawItemsJson,
  });

  // Method to copy the current Invoice instance (useful if needed)
  Invoice copy() {
    return Invoice(
      id: id,
      companyName: companyName,
      address: address,
      gstNumber: gstNumber,
      mobileNo: mobileNo,
      // panNumber: panNumber,
      stateCode: stateCode,
      invoiceNo: invoiceNo,
      date: date,
      billTaker: billTaker,
      billTakerAddress: billTakerAddress,
      billTakerMobileNo: billTakerMobileNo,
      billTakerGSTPin: billTakerGSTPin,
      // deliveryFirm: deliveryFirm,
      // deliveryFirmAddress: deliveryFirmAddress,
      // deliveryFirmMobileNo: deliveryFirmMobileNo,
      // deliveryFirmGSTPin: deliveryFirmGSTPin,
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
      rawItemsJson: rawItemsJson,
    );
  }

  // Convert the Invoice to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyName': companyName,
      'address': address,
      'gstNumber': gstNumber,
      'mobileNo': mobileNo,
      // 'panNumber': panNumber,
      'stateCode': stateCode,
      'invoiceNo': invoiceNo,
      'date': date,
      'billTaker': billTaker,
      'billTakerAddress': billTakerAddress,
      'billTakerMobileNo': billTakerMobileNo,
      'billTakerGSTPin': billTakerGSTPin,
      // 'deliveryFirm': deliveryFirm,
      // 'deliveryFirmAddress': deliveryFirmAddress,
      // 'deliveryFirmMobileNo': deliveryFirmMobileNo,
      // 'deliveryFirmGSTPin': deliveryFirmGSTPin,
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
      'rawItemsJson': rawItemsJson,
    };
  }

  // Static method to create an empty Invoice instance
  static Invoice emptyInvoice() {
    return Invoice(
      id: 0, companyName: '',
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
      rawItemsJson: "",
    );
  }
  // Static method to create an Invoice instance from a map
static Invoice fromJson(Map<String, dynamic> map) {
  return Invoice(
    id: map['id'] ?? 0,
    companyName: map['companyName'] ?? '',
    address: map['address'] ?? '',
    gstNumber: map['gstNumber'] ?? '',
    mobileNo: map['mobileNo'] ?? '',
    stateCode: map['stateCode'] ?? '24', // Default state code '24'
    invoiceNo: map['invoiceNo'] ?? '',
    date: map['date'] ?? getDate(DateTime.now()),
    billTaker: map['billTaker'] ?? '',
    billTakerAddress: map['billTakerAddress'] ?? '',
    billTakerMobileNo: map['billTakerMobileNo'] ?? '',
    billTakerGSTPin: map['billTakerGSTPin'] ?? '',
    broker: map['broker'] ?? '',
    bankName: map['bankName'] ?? '',
    bankBranch: map['bankBranch'] ?? '',
    bankAccountNo: map['bankAccountNo'] ?? '',
    bankIFSCCode: map['bankIFSCCode'] ?? '',
    remark: map['remark'] ?? '',
    discount: map['discount'] ?? '',
    othLess: map['othLess'] ?? '',
    freight: map['freight'] ?? '',
    iGst: map['iGst'] ?? '',
    sGst: map['sGst'] ?? '',
    cGst: map['cGst'] ?? '',
    rawItemsJson: map['rawItemsJson'] ?? '',
  );
}

}
