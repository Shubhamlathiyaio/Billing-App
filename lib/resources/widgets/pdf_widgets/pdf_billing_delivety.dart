import 'dart:core';

import 'package:billing/models/invoice.dart';
import 'package:billing/resources/widgets/common_pdfs/pdf_conatiner.dart';
import 'package:billing/resources/widgets/common_pdfs/pdf_text.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget billingAndDeliveryDetailsPdf(
    double baseFontSize, double pageWidth, Invoice invoice) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _headerRow("Billing Details", baseFontSize, rightBorder: 0.5),
      _detailsRow(baseFontSize, [
        [
          _labelAndData("M/S.:", invoice.billTaker, baseFontSize * 1.2),
          _labelAndData("Address:", invoice.billTakerAddress, baseFontSize),
        ],
        [
          _labelAndData("Mobile no:", invoice.billTakerMobileNo, baseFontSize),
          _labelAndData("GST PIN:", invoice.billTakerGSTPin, baseFontSize),
        ]
      ]),
      _brokerInfo(baseFontSize, pageWidth, invoice),
    ],
  );
}

pw.Widget _headerRow(String title, double baseFontSize,
    {double leftBorder = 0, double rightBorder = 0}) {
  return PDFContainer(
    horizontalBorder: 1,
    leftBorder: leftBorder,
    alignment: pw.Alignment.center,
    rightBorder: rightBorder,
    padding: const pw.EdgeInsets.symmetric(horizontal: 8),
    child: PDFText(
      data: title,
      fontSize: baseFontSize * 1.2,
    ),
  );
}

pw.Widget _detailsRow(double baseFontSize, dynamic children) =>
    pw.Row(children: [
      _detailBox(baseFontSize, children, 0),
      _detailBox(baseFontSize, children, 1)
    ]);

pw.Widget _detailBox(double baseFontSize, dynamic children, int index) {
  final commonPadding = const pw.EdgeInsets.symmetric(horizontal: 8);
  final boxHeight = baseFontSize * 5;
  return pw.Expanded(
    child: pw.Container(
      height: boxHeight,
      decoration: pw.BoxDecoration(
        border: index == 0
            ? pw.Border(right: pw.BorderSide(width: 0.5))
            : pw.Border(left: pw.BorderSide(width: 0.5)),
      ),
      padding: commonPadding,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
        children: children[index],
      ),
    ),
  );
}

pw.Widget _labelAndData(String label, String? data, double fontSize) {
  return pw.RichText(
    text: pw.TextSpan(
      children: [
        pw.TextSpan(
          text: "$label ",
          style:
              pw.TextStyle(fontSize: fontSize, fontWeight: pw.FontWeight.bold),
        ),
        if (data != null && data.trim().isNotEmpty)
          pw.TextSpan(
            text: data,
            style: pw.TextStyle(
                fontSize: fontSize, fontWeight: pw.FontWeight.normal),
          ),
      ],
    ),
  );
}

pw.Widget _brokerInfo(double baseFontSize, double width, Invoice invoice) {
  return PDFContainer(
    width: width,
    topBorder: 1,
    padding: const pw.EdgeInsets.symmetric(vertical: 1, horizontal: 8),
    child: PDFText(
      data: "Broker: ${invoice.broker}",
      fontSize: baseFontSize,
    ),
  );
}
