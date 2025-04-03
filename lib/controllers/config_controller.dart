import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum ConfigKeys {
  companyName,
  address,
  gstNumber,
  panNumber,
  stateCode,
  billTaker,
  billTakerAddress,
  billTakerGSTPin,
  userFirm,
  userFirmAddress,
  userFirmGSTPin
  //#
  //*
}

class ConfigController extends GetxController {
  final box = GetStorage();

  // Text controllers
  final companyNameController = TextEditingController();
  final addressController = TextEditingController();
  final gstNumberController = TextEditingController();
  final panNumberController = TextEditingController();
  final stateCodeController = TextEditingController();
  final billTakerController = TextEditingController();
  final billTakerAddressController = TextEditingController();
  final billTakerGSTPinController = TextEditingController();
  final userFirmController = TextEditingController();
  final userFirmAddressController = TextEditingController();
  final userFirmGSTPinController = TextEditingController();
  // final #Controller = TextEditingController();
  //*

  // Observables
  final companyName = ''.obs;
  final address = ''.obs;
  final gstNumber = ''.obs;
  final panNumber = ''.obs;
  final stateCode = ''.obs;
  final billTaker = ''.obs;
  final billTakerAddress = ''.obs;
  final billTakerGSTPin = ''.obs;
  final userFirm = ''.obs;
  final userFirmAddress = ''.obs;
  final userFirmGSTPin = ''.obs;
  // final # = ''.obs;
  //*

  @override
  void onInit() {
    super.onInit();
    loadDefaults();
  }

  // Load stored values into controllers and observables
  void loadDefaults() {
    companyName.value = companyNameController.text =box.read(ConfigKeys.companyName.name) ?? 'ABC Pvt Ltd';
    address.value = addressController.text =box.read(ConfigKeys.address.name) ?? '123, Business Street';
    gstNumber.value = gstNumberController.text =box.read(ConfigKeys.gstNumber.name) ?? '22ABCDE1234F1Z5';
    panNumber.value = panNumberController.text =box.read(ConfigKeys.panNumber.name) ?? 'ABCDE1234F';
    stateCode.value =stateCodeController.text = box.read(ConfigKeys.stateCode.name) ?? '22';
    billTaker.value = billTakerController.text =box.read(ConfigKeys.billTaker.name) ?? 'SUN FASHION';
    billTakerAddress.value = billTakerAddressController.text =box.read(ConfigKeys.billTakerAddress.name) ?? 'SUN FASHION';
    billTakerGSTPin.value = billTakerGSTPinController.text =box.read(ConfigKeys.billTakerGSTPin.name) ?? 'SUN FASHION';
    userFirm.value = userFirmController.text =box.read(ConfigKeys.userFirm.name) ?? 'LIFESTYLE';
    userFirmAddress.value = userFirmAddressController.text =box.read(ConfigKeys.userFirmAddress.name) ?? 'LIFESTYLE';
    userFirmGSTPin.value = userFirmGSTPinController.text =box.read(ConfigKeys.userFirmGSTPin.name) ?? 'LIFESTYLE';
  // #.value = #Controller.text = box.read(ConfigKeys.#.name) ?? 'LIFESTYLE';
    //*
  }

  // Save values and update observables
  void saveConfig() {
    box.write(ConfigKeys.companyName.name, companyNameController.text);
    box.write(ConfigKeys.address.name, addressController.text);
    box.write(ConfigKeys.gstNumber.name, gstNumberController.text);
    box.write(ConfigKeys.panNumber.name, panNumberController.text);
    box.write(ConfigKeys.stateCode.name, stateCodeController.text);
    box.write(ConfigKeys.billTaker.name, billTakerController.text);
    box.write(
        ConfigKeys.billTakerAddress.name, billTakerAddressController.text);
    box.write(ConfigKeys.billTakerGSTPin.name, billTakerGSTPinController.text);
    box.write(ConfigKeys.userFirm.name, userFirmController.text);
    box.write(ConfigKeys.userFirmAddress.name, userFirmAddressController.text);
    box.write(ConfigKeys.userFirmGSTPin.name, userFirmGSTPinController.text);
  // box.write(ConfigKeys.#.name,#Controller.text);
    //*

    companyName.value = companyNameController.text;
    address.value = addressController.text;
    gstNumber.value = gstNumberController.text;
    panNumber.value = panNumberController.text;
    stateCode.value = stateCodeController.text;
    billTaker.value = billTakerController.text;
    billTakerAddress.value = billTakerAddressController.text;
    billTakerGSTPin.value = billTakerGSTPinController.text;
    userFirm.value = userFirmController.text;
    userFirmAddress.value = userFirmAddressController.text;
    userFirmGSTPin.value = userFirmGSTPinController.text;
// #.value = #Controller.text;
    //*
    Get.back();
  }
}
