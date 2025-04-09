import 'dart:async';

import 'package:billing/commons/common_spacing.dart';
import 'package:billing/commons/common_text.dart';
import 'package:billing/commons/common_text_field.dart';
import 'package:billing/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

Future<TableItem?> showItemInputDialog({TableItem? item}) {
  final descCtrl = TextEditingController(text: item?.description ?? '');
  final qualityCtrl = TextEditingController(text: item?.quality ?? '');
  final hsnCtrl = TextEditingController(text: item?.hsnCode ?? '');
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
              CommonTextField(controller: descCtrl, label: 'Description'),
              CommonTextField(controller: qualityCtrl, label: 'Quality'),
              CommonTextField(
                controller: hsnCtrl,
                label: 'HSN Code',
                keyboardType: TextInputType.numberWithOptions(),
              ),
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
                    description: descCtrl.text,
                    quality: qualityCtrl.text,
                    hsnCode: hsnCtrl.text,
                    qty: double.tryParse(qtyCtrl.text) ?? 0,
                    rate: double.tryParse(rateCtrl.text) ?? 0,
                  );
                  SmartDialog.dismiss();
                  completer.complete(newItem);
                },
                child: CommonText(data: 'Save'),
              )
            ],
          ),
        ),
      ),
    ),
  );

  return completer.future;
}
