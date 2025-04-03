import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum ConfigKeys { companyName, address, gstNumber, panNumber, stateCode }

class ConfigController extends GetxController {
  final box = GetStorage();

  // Text controllers
  final companyNameController = TextEditingController();
  final addressController = TextEditingController();
  final gstNumberController = TextEditingController();
  final panNumberController = TextEditingController();
  final stateCodeController = TextEditingController();

  // Observables
  final companyName = ''.obs;
  final address = ''.obs;
  final gstNumber = ''.obs;
  final panNumber = ''.obs;
  final stateCode = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadDefaults();
  }

  // Load stored values into controllers and observables
  void loadDefaults() {
    companyName.value = companyNameController.text = box.read(ConfigKeys.companyName.name) ?? 'ABC Pvt Ltd';
    address.value = addressController.text = box.read(ConfigKeys.address.name) ?? '123, Business Street';
    gstNumber.value = gstNumberController.text = box.read(ConfigKeys.gstNumber.name) ?? '22ABCDE1234F1Z5';
    panNumber.value = panNumberController.text = box.read(ConfigKeys.panNumber.name) ?? 'ABCDE1234F';
    stateCode.value = stateCodeController.text = box.read(ConfigKeys.stateCode.name) ?? '22';
  }

  // Save values and update observables
  void saveConfig() {
    box.write(ConfigKeys.companyName.name, companyNameController.text);
    box.write(ConfigKeys.address.name, addressController.text);
    box.write(ConfigKeys.gstNumber.name, gstNumberController.text);
    box.write(ConfigKeys.panNumber.name, panNumberController.text);
    box.write(ConfigKeys.stateCode.name, stateCodeController.text);

    companyName.value = companyNameController.text;
    address.value = addressController.text;
    gstNumber.value = gstNumberController.text;
    panNumber.value = panNumberController.text;
    stateCode.value = stateCodeController.text;
  }
}
