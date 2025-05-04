import 'dart:async';

import 'package:billing/resources/commons/common_spacing.dart';
import 'package:billing/resources/commons/common_text.dart';
import 'package:billing/resources/commons/common_text_field.dart';
import 'package:billing/models/bill_taker.dart';
import 'package:billing/resources/constens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

Future<BillTaker?> showBillTakerInputDialog({BillTaker? billTaker}) {
  final nameCtrl = TextEditingController(text: billTaker?.name ?? '');
  final addressCtrl = TextEditingController(text: billTaker?.address ?? '');
  final mobileCtrl = TextEditingController(text: billTaker?.mobileNo ?? '');
  final gstCtrl = TextEditingController(text: billTaker?.gstNo ?? '');

  final completer = Completer<BillTaker?>();

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonTextField(controller: nameCtrl, label: 'Name'),
                CommonTextField(controller: addressCtrl, label: 'Address'),
                CommonTextField(
                  controller: mobileCtrl,
                  label: 'Mobile No.',
                  keyboardType: TextInputType.phone,
                ),
                CommonTextField(controller: gstCtrl, label: 'GST No.'),
                h12,
                ElevatedButton(
                  onPressed: () {
                    if (nameCtrl.text.trim().isEmpty) return;
                    final newTaker = BillTaker(
                      id: billTaker?.id,
                      name: nameCtrl.text.trim(),
                      address: addressCtrl.text.trim(),
                      mobileNo: mobileCtrl.text.trim(),
                      gstNo: gstCtrl.text.trim(),
                    );
                    SmartDialog.dismiss();
                    completer.complete(newTaker);
                  },
                  child: CommonText(data: 'Save', fontColor: onDarkBg),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );

  return completer.future;
}
