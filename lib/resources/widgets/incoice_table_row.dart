import 'package:billing/commons/common_button.dart';
import 'package:billing/commons/common_spacing.dart';
import 'package:billing/commons/common_text.dart';
import 'package:flutter/material.dart';

List<Widget> tableRow() {
  return [
    Padding(
      padding: EdgeInsets.all(8.0),
      child: CommonText(data: "1", textAlign: TextAlign.center),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Description",
              ),
            ),
          ),
          w8,
          CommonButton(onPressed: () {}, text: "Add"),
        ],
      ),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: CommonText(data: "HSN Code", textAlign: TextAlign.center),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: CommonText(data: "Qty", textAlign: TextAlign.center),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: CommonText(data: "Rate", textAlign: TextAlign.center),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: CommonText(data: "Amount", textAlign: TextAlign.center),
    ),
  ];
}
