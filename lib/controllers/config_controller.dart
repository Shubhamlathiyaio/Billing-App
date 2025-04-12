import 'package:billing/controllers/table_controller.dart';
import 'package:billing/models/invoice.dart';
import 'package:billing/models/table_item.dart';
import 'package:billing/services/small_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/config_keys.dart';
import '../models/config_fields.dart';

class ConfigController extends GetxController {
  final box = GetStorage();

  // Company
  final companyNameController = TextEditingController();
  final addressController = TextEditingController();

  // Invoice
  final gstNumberController = TextEditingController();
  final panNumberController = TextEditingController();
  final stateCodeController = TextEditingController();
  final dateController = TextEditingController();
  final invoiceNoController = TextEditingController();

  // Billing
  final billTakerController = TextEditingController();
  final billTakerAddressController = TextEditingController();
  final billTakerGSTPinController = TextEditingController();
  final userFirmController = TextEditingController();
  final userFirmAddressController = TextEditingController();
  final userFirmGSTPinController = TextEditingController();
  final brokerController = TextEditingController();

  // Discount & Taxes
  final discountController = TextEditingController();
  final othLessController = TextEditingController();
  final freightController = TextEditingController();
  final iGstController = TextEditingController();
  final sGstController = TextEditingController();
  final cGstController = TextEditingController();

  final Map<ConfigKeys, ConfigField> fields = {
    for (var key in ConfigKeys.values)
      key: ConfigField(controller: TextEditingController())
  };

  @override
  void onInit() {
    super.onInit();
    loadConfig();
  }

  // ✅ Save Config
  void saveConfig() {
    final table = Get.find<TableController>();
    box.write('config', {
      'companyName': companyName,
      'address': address,
      'gstNumber': gstNumber,
      'panNumber': panNumber,
      'stateCode': stateCode,
      'invoiceNo': invoiceNo,
      'date': date,
      'billTaker': billTaker,
      'billTakerAddress': billTakerAddress,
      'billTakerGSTPin': billTakerGSTPin,
      'userFirm': userFirm,
      'userFirmAddress': userFirmAddress,
      'userFirmGSTPin': userFirmGSTPin,
      'broker': broker,
      'discount': discount,
      'othLess': othLess,
      'freight': freight,
      'iGst': iGst,
      'sGst': sGst,
      'cGst': cGst,
      'itemList': table.itemList.map((e) => e.toJson()).toList(),
    });
  }

  // ✅ Load Config
  void loadConfig() {
    final config = box.read('config') ?? {};

    companyNameController.text = config['companyName'] ?? '';
    addressController.text = config['address'] ?? '';
    gstNumberController.text = config['gstNumber'] ?? '';
    panNumberController.text = config['panNumber'] ?? '';
    stateCodeController.text = config['stateCode'] ?? '';
    billTakerController.text = config['billTaker'] ?? '';
    billTakerAddressController.text = config['billTakerAddress'] ?? '';
    billTakerGSTPinController.text = config['billTakerGSTPin'] ?? '';
    userFirmController.text = config['userFirm'] ?? '';
    userFirmAddressController.text = config['userFirmAddress'] ?? '';
    userFirmGSTPinController.text = config['userFirmGSTPin'] ?? '';
    brokerController.text = config['broker'] ?? '';
    discountController.text = config['discount'] ?? '';
    othLessController.text = config['othLess'] ?? '';
    freightController.text = config['freight'] ?? '';
    iGstController.text = config['iGst'] ?? '';
    sGstController.text = config['sGst'] ?? '';
    cGstController.text = config['cGst'] ?? '';

    /// ✅ Auto-set date only if not saved before
    dateController.text = config['date'] ?? getTodayDate();

    /// ✅ Auto-increment invoice number
    final lastInvoiceNo = config['invoiceNo'];
    invoiceNoController.text = generateNextInvoiceNo(lastInvoiceNo);
  }

  // ✅ Convert current config to Invoice object
  Invoice getInvoice() {
    return Invoice(
      invoiceNo: invoiceNo,
      date: date,
      companyName: companyName,
      address: address,
      gstNumber: gstNumber,
      panNumber: panNumber,
      stateCode: stateCode,
      billTaker: billTaker,
      billTakerAddress: billTakerAddress,
      billTakerGSTPin: billTakerGSTPin,
      userFirm: userFirm,
      userFirmAddress: userFirmAddress,
      userFirmGSTPin: userFirmGSTPin,
      broker: broker,
      discount: discount,
      othLess: othLess,
      freight: freight,
      iGst: iGst,
      sGst: sGst,
      cGst: cGst,
    );
  }

  // ✅ Load Invoice data into config (for editing/viewing)
  void invoiceToConfig(Invoice invoice) {
    invoiceNoController.text = invoice.invoiceNo;
    dateController.text = invoice.date;
    companyNameController.text = invoice.companyName;
    addressController.text = invoice.address;
    gstNumberController.text = invoice.gstNumber;
    panNumberController.text = invoice.panNumber;
    stateCodeController.text = invoice.stateCode;
    billTakerController.text = invoice.billTaker;
    billTakerAddressController.text = invoice.billTakerAddress;
    billTakerGSTPinController.text = invoice.billTakerGSTPin;
    userFirmController.text = invoice.userFirm;
    userFirmAddressController.text = invoice.userFirmAddress;
    userFirmGSTPinController.text = invoice.userFirmGSTPin;
    brokerController.text = invoice.broker;
    discountController.text = invoice.discount.toString();
    othLessController.text = invoice.othLess.toString();
    freightController.text = invoice.freight.toString();
    iGstController.text = invoice.iGst.toString();
    sGstController.text = invoice.sGst.toString();
    cGstController.text = invoice.cGst.toString();
    Get.find<TableController>().itemList.clear();
    Get.find<TableController>().itemList.addAll(
          invoice.items.map((e) => TableItem(
                chalanNo: int.tryParse(e.chalan) ?? 0,
                itemName: e.itemName,
                taka: e.taka,
                hsnCode: e.hsnCode,
                qty: double.tryParse(e.qty) ?? 0,
                rate: double.tryParse(e.rate) ?? 0,
              )),
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'address': address,
      'gstNumber': gstNumber,
      'panNumber': panNumber,
      'stateCode': stateCode,
      'invoiceNo': invoiceNo,
      'date': date,
      'billTaker': billTaker,
      'billTakerAddress': billTakerAddress,
      'billTakerGSTPin': billTakerGSTPin,
      'userFirm': userFirm,
      'userFirmAddress': userFirmAddress,
      'userFirmGSTPin': userFirmGSTPin,
      'broker': broker,
      'discount': discount,
      'othLess': othLess,
      'freight': freight,
      'iGst': iGst,
      'sGst': sGst,
      'cGst': cGst,
    };
  }

  // Getters
  String get companyName => companyNameController.text;
  String get address => addressController.text;
  String get gstNumber => gstNumberController.text;
  String get panNumber => panNumberController.text;
  String get stateCode => stateCodeController.text;
  String get invoiceNo => invoiceNoController.text;
  String get date => dateController.text;
  String get billTaker => billTakerController.text;
  String get billTakerAddress => billTakerAddressController.text;
  String get billTakerGSTPin => billTakerGSTPinController.text;
  String get userFirm => userFirmController.text;
  String get userFirmAddress => userFirmAddressController.text;
  String get userFirmGSTPin => userFirmGSTPinController.text;
  String get broker => brokerController.text;
  String get discount => discountController.text;
  String get othLess => othLessController.text;
  String get freight => freightController.text;
  String get iGst => iGstController.text;
  String get sGst => sGstController.text;
  String get cGst => cGstController.text;

  @override
  void onClose() {
    fields.forEach((_, field) => field.dispose());
    super.onClose();
  }
}
