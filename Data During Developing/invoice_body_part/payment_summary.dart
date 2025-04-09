import 'package:billing/commons/common_container.dart';
import 'package:billing/commons/common_text.dart';
import '../invoice_controller.dart';
import 'package:billing/resources/constens.dart';
import 'package:flutter/material.dart';

Widget paymentSummary(double baseFontSize, MediaQueryData media, InvoiceController invoiceController) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _bankDetailsSection(baseFontSize, media),
          _summaryDetailsSection(baseFontSize, invoiceController),
        ],
      ),
      _dueDetailsSection(baseFontSize),
      _amountInWordsSection(baseFontSize),
      _termsAndConditionsSection(baseFontSize, media),
    ],
  );
}

Widget _bankDetailsSection(double baseFontSize, MediaQueryData media) {
  return Expanded(
    flex: 28,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _bankInfoContainer(baseFontSize),
        CommonContainer(
          height: A4RATIO * media.size.width * .05,
          topBorder: LINEWIDTH,
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.symmetric(horizontal: PADDING),
          child: CommonText(data: "Remark:", fontSize: baseFontSize),
        )
      ],
    ),
  );
}

Widget _bankInfoContainer(double baseFontSize) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: PADDING),
    child: CommonContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: ["Bank", "Branch", "A/C", "IFSC"]
            .map((text) => CommonText(data: text, fontSize: baseFontSize))
            .toList(),
      ),
    ),
  );
}

Widget _summaryDetailsSection(double baseFontSize, InvoiceController invoiceController) {
  return Expanded(
    flex: 19,
    child: CommonContainer(
      padding: EdgeInsets.symmetric(horizontal: PADDING),
      leftBorder: LINEWIDTH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var entry in [
            ["Discount", "-", invoiceController.discount.value, 00.00],
            ["Oth Less", "-", "", 00.00],
            ["Freight", "+", "", 00.00],
            ["Taxable Value", "", "", 00.00],
            ["I GST", "+", "", 00.00],
            ["S GST", "+", "", 00.00],
            ["C GST", "+", "", 00.00],
          ])
            tile(entry[0].toString(), entry[1].toString(), entry[2].toString(), double.tryParse(entry[3].toString()) ?? 0.00, baseFontSize),

        ],
      ),
    ),
  );
}

Widget _dueDetailsSection(double baseFontSize) {
  return CommonContainer(
    horizontalBorder: LINEWIDTH,
    padding: EdgeInsets.symmetric(horizontal: PADDING),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: ["DueDays:", "Due Date:", "Net Amount: "]
          .map((text) => CommonText(data: text, fontSize: baseFontSize * MEDIUM))
          .toList(),
    ),
  );
}

Widget _amountInWordsSection(double baseFontSize) {
  return CommonContainer(
    padding: EdgeInsets.symmetric(horizontal: PADDING),
    horizontalBorder: LINEWIDTH,
    child: CommonText(data: "Amount In Words : .", fontSize: baseFontSize * MEDIUM),
  );
}

Widget _termsAndConditionsSection(double baseFontSize, MediaQueryData media) {
  return CommonContainer(
    padding: EdgeInsets.symmetric(horizontal: PADDING),
    child: Row(
      children: [
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(data: "Terms and Conditions:-", fontSize: baseFontSize * MEDIUM),
              for (var term in [
                "1) Complaint, if any, regarding this Invoice must be settled immediately.",
                "2) Goods once sold will not be taken back or exchanged.",
                "3) Goods are dispatched to the account and risk of the buyer.",
                "4) Interest @2% per month will be charged on the amount remaining unpaid from the due date.",
                "5) Subject to SURAT Jurisdiction."
              ])
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: CommonText(data: term, fontSize: baseFontSize * .85),
                ),
            ],
          ),
        ),
        Expanded(
          child: CommonContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(data: "data", fontSize: baseFontSize * MEDIUM),
                SizedBox(height: media.size.width * A4RATIO*.1==0?40:media.size.width * A4RATIO*.1 ),
                CommonText(data: "Auth. Sign.", fontSize: baseFontSize),
              ],
            ),
          ),
        )
      ],
    ),
  );
}


Widget tile(String title, String sy, String per, double amount, double baseFontSize) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      for (var text in [title, sy, per.isNotEmpty ? "$per %" : "", amount.toStringAsFixed(2)])
        CommonText(data: text, fontSize: baseFontSize),
    ],
  );
}
