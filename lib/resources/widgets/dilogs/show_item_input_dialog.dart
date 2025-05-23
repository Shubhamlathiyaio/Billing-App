import 'dart:async';

import 'package:billing/resources/commons/common_spacing.dart';
import 'package:billing/resources/commons/common_text.dart';
import 'package:billing/resources/commons/common_text_field.dart';
import 'package:billing/models/table_item.dart';
import 'package:billing/resources/constens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

Future<TableItem?> showItemInputDialog({TableItem? item}) {
  final chalNo = TextEditingController(text: item?.chalanNo.toString());
  final itemNameCtrl = TextEditingController(text: item?.itemName ?? '');
  final takaCtrl = TextEditingController(text: item?.taka.toString());
  final hsnCodeCtrl = TextEditingController(text: item?.hsnCode.toString()?? "5407");
  final qtyCtrl = TextEditingController(text: item?.qty.toString() ?? '');
  final rateCtrl = TextEditingController(text: item?.rate.toString() ?? '');

  final completer = Completer<TableItem?>();

  SmartDialog.show(
    builder: (_) => Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonTextField(
                controller: chalNo,
                label: 'Chalan No',
                keyboardType: TextInputType.numberWithOptions(),
              ),
              CommonTextField(controller: itemNameCtrl, label: 'Description'),
              CommonTextField(
                  controller: takaCtrl,
                  label: 'Taka',
                  keyboardType: TextInputType.numberWithOptions()),
              CommonTextField(
                  controller: hsnCodeCtrl,
                  label: 'HSN Code',
                  keyboardType: TextInputType.numberWithOptions()),
              CommonTextField(
                  controller: qtyCtrl,
                  label: 'Qty',
                  keyboardType: TextInputType.numberWithOptions()),
              CommonTextField(
                  controller: rateCtrl,
                  label: 'Rate',
                  keyboardType: TextInputType.numberWithOptions()),
              h12,
              ElevatedButton(
                onPressed: () {
                  final newItem = TableItem(
                    chalanNo: int.tryParse(chalNo.text) ?? 0,
                    itemName: itemNameCtrl.text,
                    taka: takaCtrl.text,
                    hsnCode: hsnCodeCtrl.text,
                    qty: double.tryParse(qtyCtrl.text) ?? 0,
                    rate: double.tryParse(rateCtrl.text) ?? 0,
                  );
                  SmartDialog.dismiss();
                  completer.complete(newItem);
                },
                child: CommonText(data: 'Save',fontColor: onDarkBg),
              )
            ],
          ),
        ),
      ),
    ),
  );

  return completer.future;
}
