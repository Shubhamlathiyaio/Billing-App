import 'package:billing/models/config.dart';
import 'package:billing/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billing/commons/common_button.dart';
import 'package:billing/commons/common_text.dart';
import 'package:billing/commons/common_text_field.dart';
import 'package:billing/controllers/config_controller.dart';

class ConfigPage extends StatelessWidget {
  ConfigPage({super.key});
  final ConfigController configController = Get.put(ConfigController());
  final ConfigExpansionController expansionController =
      Get.put(ConfigExpansionController());

  @override
  Widget build(BuildContext context) {
    final List<ConfigGroup> configGroups = [
      ConfigGroup(title: "Company", fields: [
        ConfigField(label: "Company Name",controller: configController.companyNameController),
        ConfigField(label: "Address", controller: configController.addressController),
      ]),
      ConfigGroup(title: "Invoice", fields: [
        ConfigField(label: "GST No.", controller: configController.gstNumberController),
        ConfigField(label: "PAN No.", controller: configController.panNumberController),
        ConfigField(label: "State Code", controller: configController.stateCodeController, type: ConfigFieldType.number),
        ConfigField(label: "Date: ", controller: configController.dateController),
        ConfigField(label: "Invoice No", controller: configController.invoiceNoController, type: ConfigFieldType.number),
        ConfigField(label: "Chalan No", controller: configController.chalanNoController),
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
    return Scaffold(
      appBar: AppBar(
        title: CommonText(data: "Configurator"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CommonButton(
              text: "Save",
              onPressed: () {
                FocusScope.of(context).unfocus(); // hide keyboard
                configController.saveConfig();
                pageController.animateToPage(
                  1,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: configGroups.length,
            itemBuilder: (context, index) {
              final group = configGroups[index];

              return Obx(() => Card(
                    child: ExpansionTile(
                      key: Key("tile_$index ${expansionController.openTileIndex.value}"),
                      title: CommonText(data: group.title),
                      initiallyExpanded:
                          expansionController.openTileIndex.value == index,
                      onExpansionChanged: (isExpanded) {
                        if (isExpanded) {
                          expansionController
                              .toggleTile(index); // open this, close others
                        } else {
                          expansionController
                              .toggleTile(index); // close if tapped again
                        }
                      },
                      children: group.fields.map((field) {
                        if (field.type == ConfigFieldType.date) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: GestureDetector(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                if (pickedDate != null) {
                                  field.controller.text =
                                      pickedDate.toString().split(" ").first;
                                }
                              },
                              child: AbsorbPointer(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(data: field.label, fontSize: 14),
                                    CommonTextField(
                                      controller: field.controller,
                                      hintText: "Select Date",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(data: field.label, fontSize: 14),
                                CommonTextField(
                                  controller: field.controller,
                                  keyboardType:
                                      field.type == ConfigFieldType.number
                                          ? TextInputType.number
                                          : TextInputType.text,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                ),
                              ],
                            ),
                          );
                        }
                      }).toList(),
                    ),
                  ));
            },
          )),
    );
  }

  void dispose() {
    Get.delete<ConfigController>(); // this will trigger onClose()
  }
}
