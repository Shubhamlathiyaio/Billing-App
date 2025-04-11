import 'dart:math';
import 'package:billing/controllers/config_controller.dart';
import 'package:billing/models/table_item.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TableController extends GetxController {
  final ConfigController config = Get.put(ConfigController());

  // Observable item list
  var itemList = <TableItem>[].obs;

  // ✅ Totals and Calculations
  double get totalQuantity =>
      itemList.fold(0.0, (sum, item) => sum + item.quantity);

  double get subTotal =>
      itemList.fold(0.0, (sum, item) => sum + (item.quantity * item.rate));

  double get discountAmount =>
      perOf(double.tryParse(config.discount) ?? 0, subTotal);

  double get amountAfterDiscount => subTotal - discountAmount;

  double get igst =>
      perOf(double.tryParse(config.iGst) ?? 0, amountAfterDiscount);
  double get sgst =>
      perOf(double.tryParse(config.sGst) ?? 0, amountAfterDiscount);
  double get cgst =>
      perOf(double.tryParse(config.cGst) ?? 0, amountAfterDiscount);

  int get finalTotal => (amountAfterDiscount + igst + sgst + cgst).round();

  // Helper to convert percentage
  double perOf(double percent, double amount) => (percent * amount) / 100;

  // ✅ Chalan Numbers
  List<int> rawChalanNumbers = [];

  List<int> get listOfChalanNumbers =>
      [for (TableItem e in itemList) e.chalanNo];

  // ✅ Add Item
  void addItem(TableItem item) {
    rawChalanNumbers.add(item.chalanNo);
    itemList.add(item);
    saveItemsToStorage();
  }

  // ✅ Edit Item
  void editItem(int index, TableItem updatedItem) {
    rawChalanNumbers.add(updatedItem.chalanNo);
    itemList[index] = updatedItem;
    saveItemsToStorage();
  }

  // ✅ Save to local storage
  void saveItemsToStorage() {
    final data = itemList.map((e) => e.toJson()).toList();
    GetStorage().write('items', data);
  }

  // ✅ Load from local storage
  void loadItemsFromStorage() {
    final data = GetStorage().read<List>('items') ?? [];
    itemList.value = data.map((e) => TableItem.fromJson(e)).toList();
  }

  // ✅ Clear all items
  void clearTable() {
    itemList.clear();
    saveItemsToStorage();
  }
}
