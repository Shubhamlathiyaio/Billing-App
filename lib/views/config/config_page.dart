import 'package:billing/controllers/storage_controller.dart';
import 'package:billing/resources/commons/common_get_snackbar.dart';
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

  final config = Get.find<ConfigController>();
  final expansionController = Get.find<ConfigExpansionController>();

  bool hasChanges(Map<String, dynamic> current, Map<String, dynamic> original) {
    return current.toString() != original.toString();
  }

  late final List<ConfigGroup> configGroups;

  void _initializeGroups() {
    configGroups = <ConfigGroup>[
      ConfigGroup(title: "Company", fields: [
        ConfigField(
            label: "Company Name", controller: config.companyNameController),
        ConfigField(
            label: "Address",
            controller: config.addressController,
            type: ConfigFieldType.address),
      ]),
      ConfigGroup(title: "Invoice", fields: [
        ConfigField(
            label: "Invoice No",
            controller: config.invoiceNoController,
            type: ConfigFieldType.number),
        ConfigField(
            label: "GST No.",
            controller: config.gstNumberController,
            type: ConfigFieldType.numCap),
        ConfigField(
            label: "Mobile No.",
            controller: config.mobileNoController,
            type: ConfigFieldType.mobile),
        ConfigField(
            label: "State Code", controller: config.stateCodeController),
        ConfigField(
            label: "Date: ",
            controller: config.dateController,
            type: ConfigFieldType.date),
      ]),
      ConfigGroup(title: "Billing", fields: [
        ConfigField(
            label: "Bill Taker", controller: config.billTakerController),
        ConfigField(
            label: "Bill Taker Address",
            controller: config.billTakerAddressController,
            type: ConfigFieldType.address),
        ConfigField(
            label: "Bill Taker Mobile No.",
            controller: config.billTakerMobileNoController,
            type: ConfigFieldType.mobile),
        ConfigField(
            label: "Bill Taker GST Pin",
            controller: config.billTakerGSTPinController,
            type: ConfigFieldType.numCap),
        // ConfigField(label: "Delivery Firm", controller: config.deliveryFirmController),
        // ConfigField(label: "Delivery Firm Address", controller: config.deliveryFirmAddressController, type: ConfigFieldType.address),
        // ConfigField(label: "Delivery Firm Mobile No.", controller: config.deliveryFirmMobileNoController, type: ConfigFieldType.mobile),
        ConfigField(label: "Broker", controller: config.brokerController),
      ]),
      ConfigGroup(title: "Bank Details", fields: [
        ConfigField(label: "Bank Name", controller: config.bankNameController),
        ConfigField(label: "Branch", controller: config.branchNameController),
        ConfigField(
            label: "A/C",
            controller: config.accountNoController,
            type: ConfigFieldType.number),
        ConfigField(
            label: "IFSC",
            controller: config.ifscCodeController,
            type: ConfigFieldType.numCap),
      ]),
      ConfigGroup(title: "Discounts", fields: [
        ConfigField(
            label: "Discount",
            controller: config.discountController,
            type: ConfigFieldType.number),
        ConfigField(
            label: "Oth Less",
            controller: config.othLessController,
            type: ConfigFieldType.number),
        ConfigField(
            label: "Freight",
            controller: config.freightController,
            type: ConfigFieldType.number),
        ConfigField(
            label: "IGST",
            controller: config.iGstController,
            type: ConfigFieldType.number),
        ConfigField(
            label: "SGST",
            controller: config.sGstController,
            type: ConfigFieldType.number),
        ConfigField(
            label: "CGST",
            controller: config.cGstController,
            type: ConfigFieldType.number),
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
              verticalPadding: 5,
              text: "Save",
              textColor: instedOfBlack,
              backgroundColor: onDarkBg,
              onPressed: () {
                FocusScope.of(context).unfocus();
                // if (config.deliveryFirmController.text.isEmpty) config.deliveryFirmController.text = config.billTakerController.text;
                // if (config.deliveryFirmAddressController.text.isEmpty) config.deliveryFirmAddressController.text = config.billTakerAddressController.text;
                // if (config.deliveryFirmMobileNoController.text.isEmpty) config.deliveryFirmMobileNoController.text = config.billTakerMobileNoController.text;
                Get.find<ConfigController>().saveConfig();
                Get.find<StorageController>().updateUnsavedInvoice();
                print(
                    " In On Save in Config page${Get.find<StorageController>().unsavedInvoice.companyName}");
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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.find<ConfigController>().clearOtherConfigDataOnly();
    CommonSnackbar.successSnackbar("Remove", "Remove buyer data successfully.");

          },
          child: const Icon(Icons.delete)),
    );
  }
}
