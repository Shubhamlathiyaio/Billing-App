import 'package:billing/models/invoice.dart';
import 'package:billing/resources/commons/common_get_snackbar.dart';
import 'package:billing/services/small_services.dart';
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

  // Invoice
  final gstNumberController = TextEditingController();
  final mobileNoController = TextEditingController();
  // final panNumberController = TextEditingController();
  final stateCodeController = TextEditingController(text: '24');
  final dateController = TextEditingController(text: getDate(DateTime.now()));
  final invoiceNoController = TextEditingController();

  // Billing
  final billTakerController = TextEditingController();
  final billTakerAddressController = TextEditingController();
  final billTakerMobileNoController = TextEditingController();
  final billTakerGSTPinController = TextEditingController();
  // final deliveryFirmController = TextEditingController();
  // final deliveryFirmAddressController = TextEditingController();
  // final deliveryFirmMobileNoController = TextEditingController();
  // final deliveryFirmGSTPinController = TextEditingController();
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

    gstNumberController.text = config['gstNumber'] ?? '';
    mobileNoController.text = config['mobileNo'] ?? '';
    // panNumberController.text = config['panNumber'] ?? '';
    stateCodeController.text = config['stateCode'] ?? '24';
    invoiceNoController.text = generateNextInvoiceNo(config['invoiceNo']);
    dateController.text = config['date'] ?? getDate(DateTime.now());

    billTakerController.text = config['billTaker'] ?? '';
    billTakerAddressController.text = config['billTakerAddress'] ?? '';
    billTakerMobileNoController.text = config['billTakerMobileNo'] ?? '';
    billTakerGSTPinController.text = config['billTakerGSTPin'] ?? '';
    // deliveryFirmController.text = config['deliveryFirm'] ?? '';
    // deliveryFirmAddressController.text = config['deliveryFirmAddress'] ?? '';
    // deliveryFirmMobileNoController.text = config['deliveryFirmMobileNo'] ?? '';
    // deliveryFirmGSTPinController.text = config['deliveryFirmGSTPin'] ?? '';
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
    box.write('config', {
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
    });
    print("In Config save => ${companyName}");
  }

  void invoiceToConfig(Invoice invoice) {
    companyNameController.text = invoice.companyName;
    addressController.text = invoice.address;

    gstNumberController.text = invoice.gstNumber;
    mobileNoController.text = invoice.mobileNo;
    // panNumberController.text = invoice.panNumber;
    stateCodeController.text = invoice.stateCode;
    invoiceNoController.text = invoice.invoiceNo;
    dateController.text = invoice.date;

    billTakerController.text = invoice.billTaker;
    billTakerAddressController.text = invoice.billTakerAddress;
    billTakerMobileNoController.text = invoice.billTakerMobileNo;
    billTakerGSTPinController.text = invoice.billTakerGSTPin;
    // deliveryFirmController.text = invoice.deliveryFirm;
    // deliveryFirmAddressController.text = invoice.deliveryFirmAddress;
    // deliveryFirmMobileNoController.text = invoice.deliveryFirmMobileNo;
    // deliveryFirmGSTPinController.text = invoice.deliveryFirmGSTPin;
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
  }

  Map<String, dynamic> toJson() {
    return {
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

  String get gstNumber => gstNumberController.text;
  String get mobileNo => mobileNoController.text;
  // String get panNumber => panNumberController.text;
  String get stateCode => stateCodeController.text;
  String get invoiceNo => invoiceNoController.text;
  String get date => dateController.text;

  String get billTaker => billTakerController.text;
  String get billTakerAddress => billTakerAddressController.text;
  String get billTakerMobileNo => billTakerMobileNoController.text;
  String get billTakerGSTPin => billTakerGSTPinController.text;

  // String get deliveryFirm => deliveryFirmController.text;
  // String get deliveryFirmAddress => deliveryFirmAddressController.text;
  // String get deliveryFirmMobileNo => deliveryFirmMobileNoController.text;
  // String get deliveryFirmGSTPin => deliveryFirmGSTPinController.text;

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

  String generateNextInvoiceNo(String? lastInvoiceNo) {
    if (lastInvoiceNo == null) return '1';
    int currentInvoiceNo = int.tryParse(lastInvoiceNo) ?? 0;
    return (currentInvoiceNo + 1).toString();
  }

  void clearOtherConfigDataOnly() {
    final config = Get.find<ConfigController>();
    config.dateController.text = getDate(DateTime.now());
    config.billTakerController.clear();
    config.billTakerAddressController.clear();
    config.billTakerMobileNoController.clear();
    config.billTakerGSTPinController.clear();
  }
}
