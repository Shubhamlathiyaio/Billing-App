import 'package:billing/models/bill_taker.dart';
import 'package:flutter/material.dart';

class BillTakerTile extends StatelessWidget {
  final BillTaker billTaker;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const BillTakerTile({
    super.key,
    required this.billTaker,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(billTaker.name),
        subtitle: Text(billTaker.mobileNo),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
        onTap: onTap,
      ),
    );
  }
}
