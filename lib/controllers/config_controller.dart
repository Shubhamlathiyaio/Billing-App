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
  final panNumberController = TextEditingController();
  final stateCodeController = TextEditingController();
  final dateController = TextEditingController();
  final invoiceNoController = TextEditingController();

  // Billing
  final billTakerController = TextEditingController();
  final billTakerAddressController = TextEditingController();
  final billTakerGSTPinController = TextEditingController();
  final userFirmController = TextEditingController();
  final userFirmAddressController = TextEditingController();
  final userFirmGSTPinController = TextEditingController();
  final brokerController = TextEditingController();

  // Discount & Taxes
  final discountController = TextEditingController();
  final othLessController = TextEditingController();
  final freightController = TextEditingController();
  final iGstController = TextEditingController();
  final sGstController = TextEditingController();
  final cGstController = TextEditingController();

  // Getters for easy access
  // Company
  String get companyName => companyNameController.text;
  String get address => addressController.text;

  // Invoice
  String get gstNumber => gstNumberController.text;
  String get panNumber => panNumberController.text;
  String get stateCode => stateCodeController.text;
  String get invoiceNo => invoiceNoController.text;
  String get date => dateController.text;

  // Billing
  String get billTaker => billTakerController.text;
  String get billTakerAddress => billTakerAddressController.text;
  String get billTakerGSTPin => billTakerGSTPinController.text;
  String get userFirm => userFirmController.text;
  String get userFirmAddress => userFirmAddressController.text;
  String get userFirmGSTPin => userFirmGSTPinController.text;
  String get broker => brokerController.text;

  // Discount & Taxes
  String get discount => discountController.text;
  String get othLess => othLessController.text;
  String get freight => freightController.text;
  String get iGst => iGstController.text;
  String get sGst => sGstController.text;
  String get cGst => cGstController.text;

  final Map<ConfigKeys, ConfigField> fields = {
    for (var key in ConfigKeys.values)
      key: ConfigField(controller: TextEditingController())
  };

  @override
  void onInit() {
    super.onInit();
    loadConfig();
  }

  // ✅ Save Config to local
  void saveConfig() {
    box.write('config', {
      // Company
      'companyName': companyNameController.text,
      'address': addressController.text,
      // Invoice
      'gstNumber': gstNumberController.text,
      'panNumber': panNumberController.text,
      'stateCode': stateCodeController.text,
      'invoiceNo': invoiceNoController.text,
      'date': dateController.text,

      // Billing
      'billTaker': billTakerController.text,
      'billTakerAddress': billTakerAddressController.text,
      'billTakerGSTPin': billTakerGSTPinController.text,
      'userFirm': userFirmController.text,
      'userFirmAddress': userFirmAddressController.text,
      'userFirmGSTPin': userFirmGSTPinController.text,
      'broker': brokerController.text,

      // Discount & Taxes
      'discount': discountController.text,
      'othLess': othLessController.text,
      'freight': freightController.text,
      'iGst': iGstController.text,
      'sGst': sGstController.text,
      'cGst': cGstController.text,
    });
  }

  // ✅ Load Config
  void loadConfig() {
    final config = box.read('config') ?? {};
    // Company
    companyNameController.text = config['companyName'] ?? '';
    addressController.text = config['address'] ?? '';

    // Invoice
    gstNumberController.text = config['gstNumber'] ?? '';
    panNumberController.text = config['panNumber'] ?? '';
    stateCodeController.text = config['stateCode'] ?? '';
    invoiceNoController.text = config['invoiceNo'] ?? '';

    // Billing
    billTakerController.text = config['billTaker'] ?? '';
    billTakerAddressController.text = config['billTakerAddress'] ?? '';
    billTakerGSTPinController.text = config['billTakerGSTPin'] ?? '';
    userFirmController.text = config['userFirm'] ?? '';
    userFirmAddressController.text = config['userFirmAddress'] ?? '';
    userFirmGSTPinController.text = config['userFirmGSTPin'] ?? '';
    brokerController.text = config['broker'] ?? '';

    // Discount & Taxes
    discountController.text = config['discount'] ?? '';
    othLessController.text = config['othLess'] ?? '';
    freightController.text = config['freight'] ?? '';
    iGstController.text = config['iGst'] ?? '';
    sGstController.text = config['sGst'] ?? '';
    cGstController.text = config['cGst'] ?? '';
  }

  @override
  void onClose() {
    fields.forEach((_, field) => field.dispose());
    super.onClose();
  }
}
