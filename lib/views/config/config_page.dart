import 'package:billing/controllers/bill_taker_contrller.dart';
import 'package:billing/controllers/config_controller.dart';
import 'package:billing/controllers/storage_controller.dart';
import 'package:billing/models/bill_taker.dart';
import 'package:billing/models/config.dart';
import 'package:billing/resources/commons/common_button.dart';
import 'package:billing/resources/commons/common_get_snackbar.dart';
import 'package:billing/resources/constens.dart';
import 'package:billing/resources/widgets/dilogs/show_bill_taker_input_dilog.dart';
import 'package:billing/views/config/bill_taker_tile.dart';
import 'package:billing/views/config/config_group.dart';
import 'package:billing/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final config = Get.find<ConfigController>();
  final expansionController = Get.find<ConfigExpansionController>();
  late final List<ConfigGroup> configGroups;

  @override
  void initState() {
    super.initState();
    _initializeGroups();
  }

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
    final tabController = Get.find<ConfigTabController>();
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
                config.saveConfig();
                Get.find<StorageController>().updateUnsavedInvoice();
                Get.find<NavigationController>().changePage(1);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: Obx(
              () => ToggleButtons(
                isSelected: [
                  tabController.showConfig.value,
                  !tabController.showConfig.value
                ],
                onPressed: tabController.toggleTab,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text("Config"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text("Bill Taker"),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() => tabController.showConfig.value
                ? _buildConfigBody()
                : _buildBillTakerBody()),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (tabController.showConfig.value) {
            config.clearOtherConfigDataOnly();
            CommonSnackbar.successSnackbar(
                "Remove", "Removed buyer data successfully.");
          } else {
            showBillTakerInputDialog().then((value) {
              if (value != null &&
                  value.name.isNotEmpty &&
                  value.address.isNotEmpty &&
                  value.gstNo.isNotEmpty &&
                  value.mobileNo.isNotEmpty) {
                Get.find<BillTakerController>().addBillTaker(value);
                Get.find<StorageController>().updateUnsavedInvoice();
              } else {
                CommonSnackbar.errorSnackbar();
              }
            });
          }
        },
        child: Obx(() =>
            Icon(tabController.showConfig.value ? Icons.delete : Icons.add)),
      ),
    );
  }

  Widget _buildConfigBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
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

  Widget _buildBillTakerBody() {
    final controller = Get.find<BillTakerController>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() {
        List<BillTaker> billTakers = controller.billTakers;
        return billTakers.isEmpty
            ? const Center(child: Text("No Bill Takers available"))
            : ListView.builder(
                itemCount: billTakers.length,
                itemBuilder: (_, index) {
                  BillTaker billTaker = billTakers[index];
                  return BillTakerTile(
                    billTaker: billTaker,
                    onDelete: () => controller.deleteBillTaker(billTaker.id),
                    onTap: () {
                      controller.setData(billTaker);
                      Get.find<ConfigTabController>().toggleTab(0);
                      
                      final expandTile = Get.find<ConfigExpansionController>();
                      if(expandTile.openTileIndex.value!=2)expandTile.toggleTile(2);
                    },
                  );
                },
              );
      }),
    );
  }
}

class ConfigTabController extends GetxController {
  // true = Config, false = Bill Taker
  RxBool showConfig = true.obs;

  void toggleTab(int index) {
    showConfig.value = index == 0;
  }
}
