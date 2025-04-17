import 'package:billing/controllers/table_controller.dart';
import 'package:billing/models/invoice.dart';
import 'package:billing/models/table_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/config_keys.dart';
import '../models/config_fields.dart';

class ConfigController extends GetxController {
  final box = GetStorage();

  // Company
  final companyNameController = TextEditingController();
  final addressController = TextEditingController();
  final mobileNoController = TextEditingController();

  // Invoice
  final gstNumberController = TextEditingController();
  final panNumberController = TextEditingController();
  final stateCodeController = TextEditingController();
  final dateController = TextEditingController();
  final invoiceNoController = TextEditingController();

  // Billing
  final billTakerController = TextEditingController();
  final billTakerAddressController = TextEditingController();
  final billTakerMobileNoController = TextEditingController();
  final billTakerGSTPinController = TextEditingController();
  final deliveryFirmController = TextEditingController();
  final deliveryFirmAddressController = TextEditingController();
  final deliveryFirmMobileNoController = TextEditingController();
  final deliveryFirmGSTPinController = TextEditingController();
  final brokerController = TextEditingController();

  // Bank Details
  final bankNameController = TextEditingController();
  final branchNameController = TextEditingController();
  final accountNoController = TextEditingController();
  final ifscCodeController = TextEditingController();
  final remarkController = TextEditingController();

  // Discount & Taxes
  final discountController = TextEditingController();
  final othLessController = TextEditingController();
  final freightController = TextEditingController();
  final iGstController = TextEditingController();
  final sGstController = TextEditingController();
  final cGstController = TextEditingController();

  final Map<ConfigKeys, ConfigField> fields = {
    for (var key in ConfigKeys.values)
      key: ConfigField(controller: TextEditingController())
  };

  @override
  void onInit() {
    super.onInit();
    loadConfig();
  }


  void loadConfig() {
    final config = box.read('config') ?? {};

    companyNameController.text = config['companyName'] ?? '';
    addressController.text = config['address'] ?? '';
    mobileNoController.text = config['mobileNo'] ?? '';

    gstNumberController.text = config['gstNumber'] ?? '';
    panNumberController.text = config['panNumber'] ?? '';
    stateCodeController.text = config['stateCode'] ?? '';
    invoiceNoController.text = generateNextInvoiceNo(config['invoiceNo']);
    dateController.text = config['date'] ?? getTodayDate();

    billTakerController.text = config['billTaker'] ?? '';
    billTakerAddressController.text = config['billTakerAddress'] ?? '';
    billTakerMobileNoController.text = config['billTakerMobileNo'] ?? '';
    billTakerGSTPinController.text = config['billTakerGSTPin'] ?? '';
    deliveryFirmController.text = config['deliveryFirm'] ?? '';
    deliveryFirmAddressController.text = config['deliveryFirmAddress'] ?? '';
    deliveryFirmMobileNoController.text = config['deliveryFirmMobileNo'] ?? '';
    deliveryFirmGSTPinController.text = config['deliveryFirmGSTPin'] ?? '';
    brokerController.text = config['broker'] ?? '';

    bankNameController.text = config['bankName'] ?? '';
    branchNameController.text = config['branchName'] ?? '';
    accountNoController.text = config['accountNo'] ?? '';
    ifscCodeController.text = config['ifscCode'] ?? '';
    remarkController.text = config['remark'] ?? '';

    discountController.text = config['discount'] ?? '';
    othLessController.text = config['othLess'] ?? '';
    freightController.text = config['freight'] ?? '';
    iGstController.text = config['iGst'] ?? '';
    sGstController.text = config['sGst'] ?? '';
    cGstController.text = config['cGst'] ?? '';
  }

  void saveConfig() {
    final table = Get.find<TableController>();
    box.write('config', {
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
      'branchName': branchName,
      'accountNo': accountNo,
      'ifscCode': ifscCode,
      'remark': remark,
      'discount': discount,
      'othLess': othLess,
      'freight': freight,
      'iGst': iGst,
      'sGst': sGst,
      'cGst': cGst,
      'itemList': table.itemList.map((e) => e.toJson()).toList(),
    });
  }


  void invoiceToConfig(Invoice invoice) {
    companyNameController.text = invoice.companyName;
    addressController.text = invoice.address;
    mobileNoController.text = invoice.mobileNo;

    gstNumberController.text = invoice.gstNumber;
    panNumberController.text = invoice.panNumber;
    stateCodeController.text = invoice.stateCode;
    invoiceNoController.text = invoice.invoiceNo;
    dateController.text = invoice.date;

    billTakerController.text = invoice.billTaker;
    billTakerAddressController.text = invoice.billTakerAddress;
    billTakerMobileNoController.text = invoice.billTakerMobileNo;
    billTakerGSTPinController.text = invoice.billTakerGSTPin;
    deliveryFirmController.text = invoice.deliveryFirm;
    deliveryFirmAddressController.text = invoice.deliveryFirmAddress;
    deliveryFirmMobileNoController.text = invoice.deliveryFirmMobileNo;
    deliveryFirmGSTPinController.text = invoice.deliveryFirmGSTPin;
    brokerController.text = invoice.broker;

    bankNameController.text = invoice.bankName;
    branchNameController.text = invoice.bankBranch;
    accountNoController.text = invoice.bankAccountNo;
    ifscCodeController.text = invoice.bankIFSCCode;
    remarkController.text = invoice.remark;

    discountController.text = invoice.discount;
    othLessController.text = invoice.othLess;
    freightController.text = invoice.freight;
    iGstController.text = invoice.iGst;
    sGstController.text = invoice.sGst;
    cGstController.text = invoice.cGst;

    Get.find<TableController>().itemList.addAll(
      invoice.items.map(
        (e) => TableItem(
          chalanNo: int.tryParse(e.chalan) ?? 0,
          itemName: e.itemName,
          taka: e.taka,
          hsnCode: e.hsnCode,
          qty: double.tryParse(e.qty) ?? 0,
          rate: double.tryParse(e.rate) ?? 0,
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'discount': discount,
      'othLess': othLess,
      'freight': freight,
      'iGst': iGst,
      'sGst': sGst,
      'cGst': cGst,
    };
  }

  // Getters
  String get companyName => companyNameController.text;
  String get address => addressController.text;
  String get mobileNo => mobileNoController.text;

  String get gstNumber => gstNumberController.text;
  String get panNumber => panNumberController.text;
  String get stateCode => stateCodeController.text;
  String get invoiceNo => invoiceNoController.text;
  String get date => dateController.text;

  String get billTaker => billTakerController.text;
  String get billTakerAddress => billTakerAddressController.text;
  String get billTakerMobileNo => billTakerMobileNoController.text;
  String get billTakerGSTPin => billTakerGSTPinController.text;

  String get deliveryFirm => deliveryFirmController.text;
  String get deliveryFirmAddress => deliveryFirmAddressController.text;
  String get deliveryFirmMobileNo => deliveryFirmMobileNoController.text;
  String get deliveryFirmGSTPin => deliveryFirmGSTPinController.text;

  String get broker => brokerController.text;

  String get bankName => bankNameController.text;
  String get branchName => branchNameController.text;
  String get accountNo => accountNoController.text;
  String get ifscCode => ifscCodeController.text;
  String get remark => remarkController.text;

  String get discount => discountController.text;
  String get othLess => othLessController.text;
  String get freight => freightController.text;
  String get iGst => iGstController.text;
  String get sGst => sGstController.text;
  String get cGst => cGstController.text;

  String getTodayDate() {
    return DateTime.now().toString().substring(0, 10);
  }

  String generateNextInvoiceNo(String? lastInvoiceNo) {
    if (lastInvoiceNo == null) return '1';
    int currentInvoiceNo = int.tryParse(lastInvoiceNo) ?? 0;
    return (currentInvoiceNo + 1).toString();
  }
}
