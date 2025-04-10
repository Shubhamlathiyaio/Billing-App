import 'package:billing/controllers/config_controller.dart';
import 'package:billing/controllers/table_controller.dart';
import 'package:billing/services/small_services.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget paymentSummaryPdf(double fontSize) {
  final ConfigController config = Get.put(ConfigController());
  final TableController table = Get.put(TableController());
  return pw.Column(
    children: [
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          _bankDetailsSection(fontSize),
          _summaryDetailsSection(fontSize, config, table),
        ],
      ),
      _dueDetailsSection(fontSize, table),
      _amountInWordsSection(fontSize, table),
    ],
  );
}

pw.Widget _bankDetailsSection(double fontSize) {
  return pw.Expanded(
    flex: 3,
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: ["Bank", "Branch", "A/C", "IFSC"]
                .map((text) =>
                    pw.Text(text, style: pw.TextStyle(fontSize: fontSize)))
                .toList(),
          ),
        ),
        pw.Container(
          decoration: const pw.BoxDecoration(
            border: pw.Border(top: pw.BorderSide(width: 1)),
          ),
          padding: const pw.EdgeInsets.symmetric(horizontal: 8),
          alignment: pw.Alignment.bottomLeft,
          child: pw.Text("Remark:", style: pw.TextStyle(fontSize: fontSize)),
        )
      ],
    ),
  );
}

pw.Widget _summaryDetailsSection(
    double fontSize, ConfigController config, TableController table) {
  final rows = [
    ["Discount", "-", config.discount, table.discountAmount.toString()],
    ["Oth Less", "-", config.othLess, "00.00"],
    ["Freight", "+", config.freight, "00.00"],
    ["Taxable Value", "", "0", table.amountAfterDiscount.toStringAsFixed(2)],
    ["I GST", "+", config.iGst, table.igst.toStringAsFixed(2)],
    ["S GST", "+", config.sGst, table.sgst.toStringAsFixed(2)],
    ["C GST", "+", config.cGst, table.cgst.toStringAsFixed(2)],
  ];

  return pw.Expanded(
    flex: 2,
    child: pw.Container(
      decoration: const pw.BoxDecoration(
        border: pw.Border(left: pw.BorderSide(width: 1)),
      ),
      padding: const pw.EdgeInsets.symmetric(horizontal: 8),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: rows
            .map((entry) => _summaryTile(
                  entry[0],
                  entry[1],
                  entry[2],
                  entry[3],
                  fontSize,
                ))
            .toList(),
      ),
    ),
  );
}

pw.Widget _summaryTile(String title, String symbol, String percent,
    String amount, double fontSize) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 2),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(title, style: pw.TextStyle(fontSize: fontSize)),
        pw.Text(symbol, style: pw.TextStyle(fontSize: fontSize)),
        pw.Text(percent != "0" ? "$percent %" : "",
            style: pw.TextStyle(fontSize: fontSize)),
        pw.Text(amount, style: pw.TextStyle(fontSize: fontSize)),
      ],
    ),
  );
}

pw.Widget _dueDetailsSection(double fontSize, TableController table) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.symmetric(horizontal: pw.BorderSide(width: 1)),
    ),
    padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        "DueDays:",
        " ",
        "Due Date:",
        "Net Amount:",
        table.finalTotal.toStringAsFixed(2)
      ]
          .map((text) => pw.Text(text,
              style: pw.TextStyle(
                  fontSize: [for (int i = 0; i < 10; i++) "$i"]
                          .contains(text[text.length - 1])
                      ? fontSize + fontSize * .5
                      : fontSize,
                  fontWeight: pw.FontWeight.bold)))
          .toList(),
    ),
  );
}

pw.Widget _amountInWordsSection(double fontSize, TableController table) {
  return pw.Container(
    width: double.infinity,
    decoration: pw.BoxDecoration(
      border: pw.Border.symmetric(horizontal: pw.BorderSide(width: 1)),
    ),
    padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: pw.Text("Amount In Words: ${getAmountInWords(table.finalTotal)}.",
        style: pw.TextStyle(fontSize: fontSize)),
  );
}
