import 'package:pdf/widgets.dart' as pw;

pw.Widget pdfPaymentSummary(double baseFontSize, dynamic invoiceController) {
  return pw.Column(
    children: [
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          _pdfBankDetailsSection(baseFontSize),
          _pdfSummaryDetailsSection(baseFontSize, invoiceController),
        ],
      ),
      _pdfDueDetailsSection(baseFontSize),
      _pdfAmountInWordsSection(baseFontSize),
      _pdfTermsAndConditionsSection(baseFontSize),
    ],
  );
}

// 📌 Bank Details Section
pw.Widget _pdfBankDetailsSection(double baseFontSize) {
  return pw.Expanded(
    flex: 28,
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _pdfBankInfoContainer(baseFontSize),
        pw.Container(
          decoration: pw.BoxDecoration(border: pw.Border(top: pw.BorderSide(width: 1))),
          padding: const pw.EdgeInsets.symmetric(horizontal: 8),
          child: pw.Text("Remark:", style: pw.TextStyle(fontSize: baseFontSize)),
        ),
      ],
    ),
  );
}

pw.Widget _pdfBankInfoContainer(double baseFontSize) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(horizontal: 8),
    child: pw.Container(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: ["Bank", "Branch", "A/C", "IFSC"]
            .map((text) => pw.Text(text, style: pw.TextStyle(fontSize: baseFontSize)))
            .toList(),
      ),
    ),
  );
}

// 📌 Summary Details Section
pw.Widget _pdfSummaryDetailsSection(double baseFontSize, dynamic invoiceController) {
  return pw.Expanded(
    flex: 19,
    child: pw.Container(
      decoration: pw.BoxDecoration(border: pw.Border(left: pw.BorderSide(width: 1))),
      padding: const pw.EdgeInsets.symmetric(horizontal: 8),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
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
            _pdfTile(entry[0].toString(), entry[1].toString(), entry[2].toString(),
                double.tryParse(entry[3].toString()) ?? 0.00, baseFontSize),
        ],
      ),
    ),
  );
}

// 📌 Due Details Section
pw.Widget _pdfDueDetailsSection(double baseFontSize) {
  return pw.Container(
    decoration: pw.BoxDecoration(border: pw.Border(top: pw.BorderSide(width: 1))),
    padding: const pw.EdgeInsets.symmetric(horizontal: 8),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: ["DueDays:", "Due Date:", "Net Amount: "]
          .map((text) => pw.Text(text, style: pw.TextStyle(fontSize: baseFontSize * 1.1)))
          .toList(),
    ),
  );
}

// 📌 Amount in Words Section
pw.Widget _pdfAmountInWordsSection(double baseFontSize) {
  return pw.Container(
    padding: const pw.EdgeInsets.symmetric(horizontal: 8),
    decoration: pw.BoxDecoration(border: pw.Border(top: pw.BorderSide(width: 1))),
    child: pw.Text("Amount In Words: .", style: pw.TextStyle(fontSize: baseFontSize * 1.1)),
  );
}

// 📌 Terms and Conditions Section
pw.Widget _pdfTermsAndConditionsSection(double baseFontSize) {
  return pw.Container(
    padding: const pw.EdgeInsets.symmetric(horizontal: 8),
    child: pw.Row(
      children: [
        pw.Expanded(
          flex: 5,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Terms and Conditions:", style: pw.TextStyle(fontSize: baseFontSize * 1.1)),
              for (var term in [
                "1) Complaint, if any, regarding this Invoice must be settled immediately.",
                "2) Goods once sold will not be taken back or exchanged.",
                "3) Goods are dispatched to the account and risk of the buyer.",
                "4) Interest @2% per month will be charged on the amount remaining unpaid from the due date.",
                "5) Subject to SURAT Jurisdiction."
              ])
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                  child: pw.Text(term, style: pw.TextStyle(fontSize: baseFontSize * .85)),
                ),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.Container(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("data", style: pw.TextStyle(fontSize: baseFontSize * 1.1)),
                pw.SizedBox(height: 40),
                pw.Text("Auth. Sign.", style: pw.TextStyle(fontSize: baseFontSize)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// 📌 Common Tile
pw.Widget _pdfTile(String title, String sy, String per, double amount, double baseFontSize) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      for (var text in [title, sy, per.isNotEmpty ? "$per %" : "", amount.toStringAsFixed(2)])
        pw.Text(text, style: pw.TextStyle(fontSize: baseFontSize)),
    ],
  );
}
