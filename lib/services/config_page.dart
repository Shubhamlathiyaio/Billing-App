import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billing/commons/common_button.dart';
import 'package:billing/commons/common_text.dart';
import 'package:billing/commons/common_text_field.dart';
import 'package:billing/controllers/config_controller.dart';

class ConfigPage extends StatelessWidget {
  final ConfigController configController = Get.put(ConfigController());

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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _configField("Company Name", configController.companyNameController),
            _configField("Address", configController.addressController),
            _configField("GST Number", configController.gstNumberController),
            _configField("PAN Number", configController.panNumberController),
            _configField("State Code", configController.stateCodeController),
            _configField("Bill Taker", configController.billTakerController),
            _configField("Bill Taker Address", configController.billTakerAddressController),
            _configField("Bill Taker GST", configController.billTakerGSTPinController),
            _configField("User Firm", configController.userFirmController),
            _configField("User Firm Address", configController.userFirmAddressController),
            _configField("User Firm GST", configController.userFirmGSTPinController),

            Divider(), // Separates new section

            _configField("Invoice No", configController.invoiceNoController, isNumber: true),
            _configField("Discount", configController.discountController, isNumber: true),
            _configField("IGST", configController.iGstController, isNumber: true),
            _configField("SGST", configController.sGstController, isNumber: true),
            _configField("CGST", configController.cGstController, isNumber: true),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                configController.saveConfig();
              },
              child: CommonText(data: "Save Config"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _configField(String label, TextEditingController controller, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(data: label, fontSize: 16),
          CommonTextField(
            controller: controller,
            keyboardType: isNumber
                ? TextInputType.number
                    : TextInputType.text,

            textCapitalization: TextCapitalization.characters ,
          ),
        ],
      ),
    );
  }
}
