import 'package:pdf/widgets.dart' as pw;

pw.Widget pdfInvoiceDetails(dynamic configController, dynamic invoiceController) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      _pdfDetailsColumn([
        _pdfDetailText("GST No", configController.gstNumber.value),
        _pdfDetailText("PAN No", configController.panNumber.value),
        _pdfDetailText("State Code", configController.stateCode.value),
      ]),
      _pdfDetailsColumn([
        _pdfDetailText("Invoice No", invoiceController.invoiceNo.value),
        _pdfDetailText("Date", invoiceController.date.value),
        _pdfDetailText("Challan No", invoiceController.challanNo.value),
      ]),
    ],
  );
}

pw.Widget _pdfDetailsColumn(List<pw.Widget> children) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(horizontal: 8),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: children,
    ),
  );
}

pw.Widget _pdfDetailText(String label, String value) {
  return pw.Text(
    "$label: $value",
    style: pw.TextStyle(fontSize: 10),
  );
}
