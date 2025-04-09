import 'package:billing/commons/common_box_decoration.dart';
import 'package:billing/commons/common_container.dart';
import 'package:billing/commons/common_text.dart';
import 'package:billing/controllers/item_controller.dart';
import 'package:billing/models/item.dart';
import 'package:billing/resources/constens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget invoiceItemsTable(double baseFontSize, double x) {
  final itemController = Get.find<ItemController>(); // Get the controller

  return Obx(() {
    final items = itemController.itemList;

    return Table(
      columnWidths: _getColumnWidths(x),
      border: TableBorder(
        verticalInside: BorderSide(width: 1, color: Colors.black),
      ),
      children: [
        _buildHeaderRow(baseFontSize),
        ...items.asMap().entries.map(
              (entry) =>
                  _buildItemRow(baseFontSize, entry.key + 1, entry.value),
            ),
        _buildSubTotalRow(baseFontSize, items),
      ],
    );
  });
}

Map<int, TableColumnWidth> _getColumnWidths(double x) {
  return {
    0: IntrinsicColumnWidth(), // Sr No
    1: FlexColumnWidth(), // Description
    2: FixedColumnWidth(x * 20 / 3), // Quality
    3: FixedColumnWidth(x * 15 / 3), // HSN Code
    4: FixedColumnWidth((x * 20) / 3), // Qty
    5: FixedColumnWidth(x * 15 / 3), // Rate
    6: FixedColumnWidth((x * 22) / 3), // Amount
  };
}

TableRow _buildHeaderRow(double baseFontSize) {
  List<String> headers = [
    "Sr No",
    "Description",
    "Quality",
    "HSN Code",
    "Qty",
    "Rate",
    "Amount"
  ];

  return TableRow(
    decoration: CommonBoxDecoration.ui(horizontalBorderWidth: LINEWIDTH),
    children: headers
        .map(
          (header) => Padding(
            padding: EdgeInsets.all(PADDING),
            child: CommonText(
              data: header,
              fontSize: baseFontSize * MEDIUM,
              textAlign: TextAlign.center,
            ),
          ),
        )
        .toList(),
  );
}

TableRow _buildItemRow(double baseFontSize, int index, TableItem item) {
  final amount = item.qty * item.rate;
  final itemController = Get.find<ItemController>();

  return TableRow(
    children: [
      _cell(index.toString(), baseFontSize), // Sr No
      _cell(item.description, baseFontSize), // Description
      _cell(item.quality, baseFontSize), // Quality
      _cell(item.hsnCode, baseFontSize), // HSN Code
      _cell(item.qty.toStringAsFixed(2), baseFontSize), // Qty
      _cell(item.rate.toStringAsFixed(2), baseFontSize), // Rate
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              data: amount.toStringAsFixed(2),
              fontSize: baseFontSize * 0.9,
            ),
            IconButton(
              icon: Icon(Icons.delete, size: baseFontSize),
              onPressed: () {
                itemController.removeItem(index - 1); // index-1 for list
              },
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _cell(String text, double fontSize) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: CommonText(data: text, fontSize: fontSize * 0.9),
  );
}

TableRow _buildSubTotalRow(double baseFontSize, List<TableItem> items) {
  final totalQty = items.fold<double>(0, (sum, item) => sum + item.qty);
  final totalAmount =
      items.fold<double>(0, (sum, item) => sum + item.qty * item.rate);

  return TableRow(
    decoration: CommonBoxDecoration.ui(horizontalBorderWidth: LINEWIDTH),
    children: [
      SizedBox.shrink(),
      _centeredContainer("Sub Total", baseFontSize),
      SizedBox.shrink(),
      SizedBox.shrink(),
      _centeredContainer(totalQty.toStringAsFixed(2), baseFontSize),
      SizedBox.shrink(),
      _rightAlignedContainer(totalAmount.toStringAsFixed(2), baseFontSize),
    ],
  );
}

Widget _centeredContainer(String text, double baseFontSize) {
  return CommonContainer(
    alignment: Alignment.center,
    child: CommonText(data: text, fontSize: baseFontSize),
  );
}

Widget _rightAlignedContainer(String text, double baseFontSize) {
  return CommonContainer(
    padding: EdgeInsets.only(right: PADDING),
    alignment: Alignment.centerRight,
    child: CommonText(data: text, fontSize: baseFontSize),
  );
}
