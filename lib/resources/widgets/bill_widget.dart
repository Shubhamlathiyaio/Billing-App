import 'package:flutter/material.dart';

class BillWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("🧾 Invoice", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("Item: Flutter Course"),
          Text("Price: \$50"),
          SizedBox(height: 8),
          Text("Total: \$50", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
