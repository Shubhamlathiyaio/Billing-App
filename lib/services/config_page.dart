import 'package:billing/commons/common_button.dart';
import 'package:billing/commons/common_spacing.dart';
import 'package:billing/commons/common_text.dart';
import 'package:billing/controllers/config_controller.dart';
import 'package:billing/resources/widgets/config_text_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigPage extends StatelessWidget {
  final configController = Get.find<ConfigController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(data: "Configurator"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CommonButton(
              text: "Save",
              onPressed: () => configController.saveConfig(),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ConfigItemWidget(label: "Company Name", controller: configController.companyNameController),
          ConfigItemWidget(label: "Address", controller: configController.addressController),
          ConfigItemWidget(label: "GST Number", controller: configController.gstNumberController),
          ConfigItemWidget(label: "PAN Number", controller: configController.panNumberController),
          ConfigItemWidget(label: "State Code", controller: configController.stateCodeController),
          ConfigItemWidget(label: "Bill Taker", controller: configController.billTakerController),
          ConfigItemWidget(label: "Bill Taker Address", controller: configController.billTakerAddressController),
          ConfigItemWidget(label: "Bill Taker GST PIN", controller: configController.billTakerGSTPinController),
          ConfigItemWidget(label: "User Firm", controller: configController.userFirmController),
          ConfigItemWidget(label: "User Firm Address", controller: configController.userFirmAddressController),
          ConfigItemWidget(label: "userFirmGSTPin", controller: configController.userFirmGSTPinController),
          //ConfigItemWidget(label: "#", controller: configController.#Controller),
          
          h20,
        ],
      ),
    );
  }
}
