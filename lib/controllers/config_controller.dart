import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum ConfigKeys {
  // Company
  companyName,
  address,
  // Invoice
  gstNumber,
  panNumber,
  stateCode,
  invoiceNo,
  date,
  chalanNo,
  // Billing
  billTaker,
  billTakerAddress,
  billTakerGSTPin,
  userFirm,
  userFirmAddress,
  userFirmGSTPin,
  broker,
  // Discount
  discount,
  iGst,
  sGst,
  cGst,
  othLess,
  freight,
}

class ConfigController extends GetxController {
  final box = GetStorage();
  final RxString expandedGroup = ''.obs;

  // Text controllers
  // Company
  final companyNameController = TextEditingController();
  final addressController = TextEditingController();

  // Invoice
  final gstNumberController = TextEditingController();
  final panNumberController = TextEditingController();
  final stateCodeController = TextEditingController();
  final invoiceNoController = TextEditingController();
  final dateController = TextEditingController();
  final chalanNoController = TextEditingController();

  // Billing
  final billTakerController = TextEditingController();
  final billTakerAddressController = TextEditingController();
  final billTakerGSTPinController = TextEditingController();
  final userFirmController = TextEditingController();
  final userFirmAddressController = TextEditingController();
  final userFirmGSTPinController = TextEditingController();
  final brokerController = TextEditingController();
  
  // Discount
  final discountController = TextEditingController();
  final iGstController = TextEditingController();
  final sGstController = TextEditingController();
  final cGstController = TextEditingController();
  final othLessController = TextEditingController();
  final freightController = TextEditingController();

  // Observables
  // Company
  final companyName = ''.obs;
  final address = ''.obs;

  // Invoice
  final gstNumber = ''.obs;
  final panNumber = ''.obs;
  final stateCode = ''.obs;
  final invoiceNo = ''.obs;
  final date = ''.obs;
  final chalanNo = ''.obs;

  // Billing
  final billTaker = ''.obs;
  final billTakerAddress = ''.obs;
  final billTakerGSTPin = ''.obs;
  final userFirm = ''.obs;
  final userFirmAddress = ''.obs;
  final userFirmGSTPin = ''.obs;
  final broker = ''.obs;

  // Discount
  final discount = ''.obs;
  final iGst = ''.obs;
  final sGst = ''.obs;
  final cGst = ''.obs;
  final othLess = ''.obs;
  final freight = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadDefaults();
  }

  // Load stored values into controllers and observables
  void loadDefaults() {
    // Company
    companyName.value = companyNameController.text = box.read(ConfigKeys.companyName.name) ?? 'ABC Pvt Ltd';
    address.value = addressController.text = box.read(ConfigKeys.address.name) ?? '123, Business Street';
    
    // Invoice
    gstNumber.value = gstNumberController.text = box.read(ConfigKeys.gstNumber.name) ?? '22ABCDE1234F1Z5';
    panNumber.value = panNumberController.text = box.read(ConfigKeys.panNumber.name) ?? 'ABCDE1234F';
    stateCode.value = stateCodeController.text = box.read(ConfigKeys.stateCode.name) ?? '22';
    invoiceNo.value = invoiceNoController.text = box.read(ConfigKeys.invoiceNo.name) ?? '0001';
    date.value = dateController.text = box.read(ConfigKeys.date.name) ?? '${DateTime.now().toLocal()}';
    chalanNo.value = chalanNoController.text = box.read(ConfigKeys.chalanNo.name) ?? '';

    // Billing
    billTaker.value = billTakerController.text = box.read(ConfigKeys.billTaker.name) ?? 'SUN FASHION';
    billTakerAddress.value = billTakerAddressController.text = box.read(ConfigKeys.billTakerAddress.name) ?? 'SUN FASHION';
    billTakerGSTPin.value = billTakerGSTPinController.text = box.read(ConfigKeys.billTakerGSTPin.name) ?? 'SUN FASHION';
    userFirm.value = userFirmController.text = box.read(ConfigKeys.userFirm.name) ?? 'LIFESTYLE';
    userFirmAddress.value = userFirmAddressController.text = box.read(ConfigKeys.userFirmAddress.name) ?? 'LIFESTYLE';
    userFirmGSTPin.value = userFirmGSTPinController.text = box.read(ConfigKeys.userFirmGSTPin.name) ?? 'LIFESTYLE';

    // Discount
    broker.value = brokerController.text = box.read(ConfigKeys.broker.name) ?? 'LIFESTYLE';
    discount.value = discountController.text = box.read(ConfigKeys.discount.name) ?? '0';
    iGst.value = iGstController.text = box.read(ConfigKeys.iGst.name) ?? '0';
    sGst.value = sGstController.text = box.read(ConfigKeys.sGst.name) ?? '0';
    cGst.value = cGstController.text = box.read(ConfigKeys.cGst.name) ?? '0';
    othLess.value = othLessController.text = box.read(ConfigKeys.othLess.name) ?? '0';
    freight.value = freightController.text = box.read(ConfigKeys.freight.name) ?? '0';
  }

  // Save values and update observables
  void saveConfig() {
    // Company
    box.write(ConfigKeys.companyName.name, companyNameController.text);
    box.write(ConfigKeys.address.name, addressController.text);
    
    // Invoice
    box.write(ConfigKeys.gstNumber.name, gstNumberController.text);
    box.write(ConfigKeys.panNumber.name, panNumberController.text);
    box.write(ConfigKeys.stateCode.name, stateCodeController.text);
    box.write(ConfigKeys.invoiceNo.name, invoiceNoController.text);
    box.write(ConfigKeys.date.name, dateController.text);
    box.write(ConfigKeys.chalanNo.name, chalanNoController.text);

    // Billing
    box.write(ConfigKeys.billTaker.name, billTakerController.text);
    box.write(ConfigKeys.billTakerAddress.name, billTakerAddressController.text);
    box.write(ConfigKeys.billTakerGSTPin.name, billTakerGSTPinController.text);
    box.write(ConfigKeys.userFirm.name, userFirmController.text);
    box.write(ConfigKeys.userFirmAddress.name, userFirmAddressController.text);
    box.write(ConfigKeys.userFirmGSTPin.name, userFirmGSTPinController.text);
    box.write(ConfigKeys.broker.name, brokerController.text);

    // Discount
    box.write(ConfigKeys.discount.name, discountController.text);
    box.write(ConfigKeys.iGst.name, iGstController.text);
    box.write(ConfigKeys.sGst.name, sGstController.text);
    box.write(ConfigKeys.cGst.name, cGstController.text);
    box.write(ConfigKeys.othLess.name, othLessController.text);
    box.write(ConfigKeys.freight.name, freightController.text);

    // Update observables
    companyName.value = companyNameController.text;
    address.value = addressController.text;
    
    gstNumber.value = gstNumberController.text;
    panNumber.value = panNumberController.text;
    stateCode.value = stateCodeController.text;
    invoiceNo.value = invoiceNoController.text;
    date.value = dateController.text;
    chalanNo.value = chalanNoController.text;

    billTaker.value = billTakerController.text;
    billTakerAddress.value = billTakerAddressController.text;
    billTakerGSTPin.value = billTakerGSTPinController.text;
    userFirm.value = userFirmController.text;
    userFirmAddress.value = userFirmAddressController.text;
    userFirmGSTPin.value = userFirmGSTPinController.text;
    broker.value = brokerController.text;

    discount.value = discountController.text;
    iGst.value = iGstController.text;
    sGst.value = sGstController.text;
    cGst.value = cGstController.text;
    othLess.value = othLessController.text;
    freight.value = freightController.text;

    Get.back();
  }

  @override
  void onClose() {
    // Company
    companyNameController.dispose();
    addressController.dispose();
    
    // Invoice
    gstNumberController.dispose();
    panNumberController.dispose();
    stateCodeController.dispose();
    invoiceNoController.dispose();
    dateController.dispose();
    chalanNoController.dispose();

    // Billing
    billTakerController.dispose();
    billTakerAddressController.dispose();
    billTakerGSTPinController.dispose();
    userFirmController.dispose();
    userFirmAddressController.dispose();
    userFirmGSTPinController.dispose();
    brokerController.dispose();
    
    // Discount
    discountController.dispose();
    iGstController.dispose();
    sGstController.dispose();
    cGstController.dispose();
    othLessController.dispose();
    freightController.dispose();

    super.onClose();
  }
}
