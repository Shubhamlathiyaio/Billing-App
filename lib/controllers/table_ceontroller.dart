import 'package:billing/controllers/config_controller.dart';
import 'package:billing/models/item.dart';
import 'package:billing/services/calculation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TableController extends GetxController {
  final ConfigController config = Get.put(ConfigController());

  double get subTotal => itemList.fold(0.0, (sum, item) => sum + (item.qty * item.rate));
 
  // Discount
  double get discount => perOf(rxStringToDouble(config.discount), subTotal);
  String get discountAmount => discount.toString();

// After discount
  double get amountAfterDiscount => subTotal - discount;

// Taxes
  double get igst => perOf(rxStringToDouble(config.iGst), amountAfterDiscount);
  double get sgst => perOf(rxStringToDouble(config.sGst), amountAfterDiscount);
  double get cgst => perOf(rxStringToDouble(config.cGst), amountAfterDiscount);

// Grand Total
int get finalTotal => (amountAfterDiscount + igst + sgst + cgst).round();


// Helper to convert percentage
  double perOf(double percent, double amount) => (percent * amount) / 100;

  var itemList = <TableItem>[].obs;

  // ✅ Add Item
  void addItem(TableItem item) {
    itemList.add(item);
    saveItemsToStorage();
  }

  // ✅ Edit Item
  void editItem(int index, TableItem updatedItem) {
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
  void clearItems() {
    itemList.clear();
    saveItemsToStorage();
  }
}
