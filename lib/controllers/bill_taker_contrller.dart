import 'package:billing/controllers/config_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/bill_taker.dart'; // Adjust path as needed

class BillTakerController extends GetxController {
  final _storage = GetStorage();
  final storageKey = 'billTakerList';

  // List of BillTakers
  var billTakers = <BillTaker>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadList();
  }

  // Load BillTakers from storage
  void loadList() {
    final data = _storage.read(storageKey);
    if (data != null) {
      billTakers.value = List<Map<String, dynamic>>.from(data)
          .map((e) => BillTaker.fromJson(e))
          .toList();
    }
  }

  // Save BillTakers to storage
  void saveList() {
    _storage.write(storageKey, billTakers.map((e) => e.toJson()).toList());
  }

  // Add a new BillTaker to the list
  void addBillTaker(BillTaker bt) {
    billTakers.add(bt);
    saveList();
  }

  // Delete a BillTaker by its ID
  void deleteBillTaker(String id) {
    billTakers.removeWhere((bt) => bt.id == id);
    saveList();
  }

  // Clear all BillTakers
  void clearAll() {
    billTakers.clear();
    _storage.remove(storageKey);
  }

  void setData(BillTaker billTaker) {
    ConfigController config = Get.find<ConfigController>();
    config.billTakerController.text = billTaker.name;
    config.billTakerAddressController.text = billTaker.address;
    config.billTakerMobileNoController.text = billTaker.mobileNo;
    config.billTakerGSTPinController.text = billTaker.gstNo;
  }
}
