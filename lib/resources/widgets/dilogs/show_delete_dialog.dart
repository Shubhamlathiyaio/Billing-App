import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

void showDeleteDialog(VoidCallback onConfirm) async {
  return SmartDialog.show(
    builder: (_) => AlertDialog(
      title: const Text('Delete Item?'),
      content: const Text('Are you sure you want to delete this item?'),
      actions: [
        TextButton(
          onPressed: () => SmartDialog.dismiss(), // Cancel
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // your delete logic here
            SmartDialog.dismiss(); // Close dialog after delete
            onConfirm();
          },
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}
