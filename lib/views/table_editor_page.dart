import 'package:billing/resources/commons/common_text.dart';
import 'package:billing/controllers/table_controller.dart';
import 'package:billing/models/table_item.dart';
import 'package:billing/resources/constens.dart';
import 'package:billing/resources/widgets/show_clear_table.dart';
import 'package:billing/resources/widgets/show_item_input_dialog.dart';
import 'package:billing/services/small_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TableEditorPage extends StatelessWidget {
  const TableEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final itemController = Get.find<TableController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Table Editor"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:7),
            child: ElevatedButton.icon(
              onPressed: () {
                showClearTableDialog(() {
                  itemController.clearItems();
                },);
              },
              icon: const Icon(Icons.delete_forever),
              label: const CommonText(data: 'Clear Data'),
              style: ElevatedButton.styleFrom(backgroundColor: onDarkBg),
              
            ),
          ),
        ],
      ),
      body: Obx(() {
        final items = itemController.itemList;

        if (items.isEmpty) {
          return const Center(child: CommonText(data: "No items added."));
        }

        return ReorderableListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          onReorder: (oldIndex, newIndex) {
            if (newIndex > oldIndex) newIndex -= 1;
            final item = items.removeAt(oldIndex);
            items.insert(newIndex, item);
          },
          itemBuilder: (context, index) {
            final item = items[index];
            return cusomeTile(index, item, context, Key('$index'));
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showItemInputDialog().then((value) {
          if (value != null) itemController.addItem(value);
        }),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget cusomeTile(int index, TableItem item, BuildContext context, Key key) {
    return Card(
      key: key,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ReorderableDragStartListener(
              index: index,
              child: const Icon(Icons.drag_handle, color: Colors.grey),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: getColor(item.chalanNo),
              child: CommonText(
                data: "${index + 1}",
                style: TextStyle(),
              ),
            ),
          ],
        ),
        title: CommonText(
          data: item.itemName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle:
            CommonText(data: "Qty: ${item.quantity}, Rate: ₹${item.rate}"),
        trailing: Wrap(
          children: [
            IconButton(
              icon: Icon(Icons.edit,color: instedOfBlack),
              onPressed: () {
                showItemInputDialog(item: item).then((value) {
                  if (value != null) {
                    Get.find<TableController>().itemList[index] = value;
                  }
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: instedOfBlack),
              onPressed: () {
                Get.find<TableController>().itemList.remove(item);
              },
            ),
          ],
        ),
      ),
    );
  }
}
