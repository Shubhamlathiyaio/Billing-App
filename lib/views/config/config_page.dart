import 'package:billing/resources/constens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billing/controllers/config_controller.dart';
import 'package:billing/models/config.dart';
import 'package:billing/resources/commons/common_button.dart';
import 'package:billing/views/config/config_group.dart';
import 'package:billing/views/home_page.dart';

class ConfigPage extends StatelessWidget {
  ConfigPage({super.key}) {
    _initializeGroups();
  }

  final config = Get.put(ConfigController());
  final expansionController = Get.put(ConfigExpansionController());


  bool hasChanges(Map<String, dynamic> current, Map<String, dynamic> original) {
  return current.toString() != original.toString();
}


  late final List<ConfigGroup> configGroups;

  void _initializeGroups() {
    configGroups = <ConfigGroup>[
      ConfigGroup(title: "Company", fields: [
        ConfigField(label: "Company Name", controller: config.companyNameController),
        ConfigField(label: "Address", controller: config.addressController),
      ]),
      ConfigGroup(title: "Invoice", fields: [
        ConfigField(label: "GST No.", controller: config.gstNumberController),
        ConfigField(label: "PAN No.", controller: config.panNumberController),
        ConfigField(label: "State Code", controller: config.stateCodeController, type: ConfigFieldType.number),
        ConfigField(label: "Date: ", controller: config.dateController, type: ConfigFieldType.date),
        ConfigField(label: "Invoice No", controller: config.invoiceNoController, type: ConfigFieldType.number),
      ]),
      ConfigGroup(title: "Billing", fields: [
        ConfigField(label: "Bill Taker", controller: config.billTakerController),
        ConfigField(label: "Bill Taker Address", controller: config.billTakerAddressController),
        ConfigField(label: "Bill Taker GST Pin", controller: config.billTakerGSTPinController, type: ConfigFieldType.number),
        ConfigField(label: "User Firm", controller: config.userFirmController),
        ConfigField(label: "User Firm Address", controller: config.userFirmAddressController),
        ConfigField(label: "User Firm GST Pin", controller: config.userFirmGSTPinController, type: ConfigFieldType.number),
      ]),
      ConfigGroup(title: "Discounts", fields: [
        ConfigField(label: "Discount", controller: config.discountController, type: ConfigFieldType.number),
        ConfigField(label: "IGST", controller: config.iGstController, type: ConfigFieldType.number),
        ConfigField(label: "SGST", controller: config.sGstController, type: ConfigFieldType.number),
        ConfigField(label: "CGST", controller: config.cGstController, type: ConfigFieldType.number),
      ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurator"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CommonButton(verticalPadding: 5,
              text: "Save",textColor: instedOfBlack,
              backgroundColor: onDarkBg,
              onPressed: () {
                FocusScope.of(context).unfocus();
                config.saveConfig();
                Get.find<NavigationController>().changePage(1);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: configGroups.length,
          itemBuilder: (_, index) {
            return ConfigGroupCard(
              group: configGroups[index],
              index: index,
            );
          },
        ),
      ),
    );
  }
}
