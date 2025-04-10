import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

void showClearTableDialog(VoidCallback onConfirm) {
  SmartDialog.show(
    alignment: Alignment.center,
    builder: (_) => AlertDialog(
      title: const Text("Clear Table?"),
      content: const Text("Are you sure you want to clear all table items? This action cannot be undone."),
      actions: [
        TextButton(
          onPressed: () => SmartDialog.dismiss(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            SmartDialog.dismiss();
            onConfirm(); // perform your clear action here
          },
          child: const Text("Clear"),
        ),
      ],
    ),
  );
}
