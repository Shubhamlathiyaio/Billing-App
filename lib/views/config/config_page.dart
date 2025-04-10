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

  final configController = Get.put(ConfigController());
  final expansionController = Get.put(ConfigExpansionController());

  late final List<ConfigGroup> configGroups;

  void _initializeGroups() {
    configGroups = <ConfigGroup>[
      ConfigGroup(title: "Company", fields: [
        ConfigField(label: "Company Name", controller: configController.companyNameController),
        ConfigField(label: "Address", controller: configController.addressController),
      ]),
      ConfigGroup(title: "Invoice", fields: [
        ConfigField(label: "GST No.", controller: configController.gstNumberController),
        ConfigField(label: "PAN No.", controller: configController.panNumberController),
        ConfigField(label: "State Code", controller: configController.stateCodeController, type: ConfigFieldType.number),
        ConfigField(label: "Date: ", controller: configController.dateController, type: ConfigFieldType.date),
        ConfigField(label: "Invoice No", controller: configController.invoiceNoController, type: ConfigFieldType.number),
      ]),
      ConfigGroup(title: "Billing", fields: [
        ConfigField(label: "Bill Taker", controller: configController.billTakerController),
        ConfigField(label: "Bill Taker Address", controller: configController.billTakerAddressController),
        ConfigField(label: "Bill Taker GST Pin", controller: configController.billTakerGSTPinController, type: ConfigFieldType.number),
        ConfigField(label: "User Firm", controller: configController.userFirmController),
        ConfigField(label: "User Firm Address", controller: configController.userFirmAddressController),
        ConfigField(label: "User Firm GST Pin", controller: configController.userFirmGSTPinController, type: ConfigFieldType.number),
      ]),
      ConfigGroup(title: "Discounts", fields: [
        ConfigField(label: "Discount", controller: configController.discountController, type: ConfigFieldType.number),
        ConfigField(label: "IGST", controller: configController.iGstController, type: ConfigFieldType.number),
        ConfigField(label: "SGST", controller: configController.sGstController, type: ConfigFieldType.number),
        ConfigField(label: "CGST", controller: configController.cGstController, type: ConfigFieldType.number),
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
            child: CommonButton(
              text: "Save",textColor: instedOfBlack,
              backgroundColor: onDarkBg,
              onPressed: () {
                FocusScope.of(context).unfocus();
                configController.saveConfig();
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
