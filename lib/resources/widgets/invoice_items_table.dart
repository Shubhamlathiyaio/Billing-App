import 'package:billing/commons/common_box_decoration.dart';
import 'package:billing/commons/common_container.dart';
import 'package:billing/commons/common_text.dart';
import 'package:billing/resources/constens.dart';
import 'package:flutter/material.dart';

Widget invoiceItemsTable(double baseFontSize, double x) {
  return Table(
    columnWidths: _getColumnWidths(x),
    border: TableBorder(
      verticalInside: BorderSide(width: 1, color: Colors.black),
    ),
    children: [
      _buildHeaderRow(baseFontSize),
      ...List.generate(5, (index) => _buildEmptyRow(baseFontSize)),
      _buildSubTotalRow(baseFontSize),
    ],
  );
}

Map<int, TableColumnWidth> _getColumnWidths(double x) {
  return {
    0: IntrinsicColumnWidth(),
    1: FlexColumnWidth(),
    2: FixedColumnWidth(x * 20 / 3),
    3: FixedColumnWidth(x * 15 / 3),
    4: FixedColumnWidth((x * 20) / 3 - 1),
    5: FixedColumnWidth(x * 15 / 3),
    6: FixedColumnWidth((x * 22) / 3),
  };
}

TableRow _buildHeaderRow(double baseFontSize) {
  List<String> headers = ["Sr No", "Description", "Quality", "HSN Code", "Qty", "Rate", "Amount"];

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

TableRow _buildEmptyRow(double baseFontSize) {
  return TableRow(
    children: List.generate(
      7,
      (i) => Padding(
        padding: EdgeInsets.all(8.0),
        child: CommonText(data: " ", fontSize: baseFontSize * 0.9),
      ),
    ),
  );
}

TableRow _buildSubTotalRow(double baseFontSize) {
  return TableRow(
    decoration: CommonBoxDecoration.ui(horizontalBorderWidth: LINEWIDTH),
    children: [
      SizedBox.shrink(),
      _centeredContainer("Sub Total", baseFontSize),
      SizedBox.shrink(),
      SizedBox.shrink(),
      _centeredContainer("00.00", baseFontSize),
      SizedBox.shrink(),
      _rightAlignedContainer("00.00", baseFontSize),
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
