import 'package:billing/resources/commons/common_container.dart';
import 'package:billing/resources/commons/common_text.dart';
import 'package:billing/resources/constens.dart';
import 'package:flutter/material.dart';

Widget invoiceDetails(double baseFontSize, dynamic configController, dynamic invoiceController) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: PADDING),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailText("GST No", configController.gstNumber.value, baseFontSize * MEDIUM),
            _detailText("PAN No", configController.panNumber.value, baseFontSize),
            _detailText("State Code", configController.stateCode.value, baseFontSize),
          ],
        ),
      ),
      const Spacer(),
      CommonContainer(
        leftBorder: LINEWIDTH,
        padding: const EdgeInsets.symmetric(horizontal: PADDING),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailText("Invoice No", invoiceController.invoiceNo.value, baseFontSize),
            _detailText("Date", invoiceController.date.value, baseFontSize),
            _detailText("Challan No", invoiceController.challanNo.value, baseFontSize),
          ],
        ),
      ),
      const Spacer(),
    ],
  );
}

Widget _detailText(String label, String value, double fontSize) {
  return CommonText(
    data: "$label: $value",
    fontSize: fontSize,
    fontWeight: FontWeight.normal,
  );
}
