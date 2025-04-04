import 'package:pdf/widgets.dart' as pw;

pw.Widget pdfInvoiceItemsTable() {
  return pw.Table(
    border: pw.TableBorder.all(width: 0.5),
    columnWidths: _pdfGetColumnWidths(),
    children: [
      _pdfBuildHeaderRow(),
      ...List.generate(5, (index) => _pdfBuildEmptyRow()),
      _pdfBuildSubTotalRow(),
    ],
  );
}

Map<int, pw.TableColumnWidth> _pdfGetColumnWidths() {
  return {
    0: const pw.IntrinsicColumnWidth(),
    1: const pw.FlexColumnWidth(),
    2: const pw.FixedColumnWidth(50),
    3: const pw.FixedColumnWidth(40),
    4: const pw.FixedColumnWidth(50),
    5: const pw.FixedColumnWidth(40),
    6: const pw.FixedColumnWidth(60),
  };
}

pw.TableRow _pdfBuildHeaderRow() {
  List<String> headers = ["Sr No", "Description", "Quality", "HSN Code", "Qty", "Rate", "Amount"];

  return pw.TableRow(
    decoration: pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(width: 1))),
    children: headers
        .map(
          (header) => pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text(
              header,
              style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
              textAlign: pw.TextAlign.center,
            ),
          ),
        )
        .toList(),
  );
}

pw.TableRow _pdfBuildEmptyRow() {
  return pw.TableRow(
    children: List.generate(
      7,
      (i) => pw.Padding(
        padding: const pw.EdgeInsets.all(4),
        child: pw.Text(" ", style: pw.TextStyle(fontSize: 9)),
      ),
    ),
  );
}

pw.TableRow _pdfBuildSubTotalRow() {
  return pw.TableRow(
    decoration: pw.BoxDecoration(border: pw.Border(top: pw.BorderSide(width: 1))),
    children: [
      pw.Container(),
      _pdfCenteredContainer("Sub Total"),
      pw.Container(),
      pw.Container(),
      _pdfCenteredContainer("00.00"),
      pw.Container(),
      _pdfRightAlignedContainer("00.00"),
    ],
  );
}

pw.Widget _pdfCenteredContainer(String text) {
  return pw.Container(
    alignment: pw.Alignment.center,
    padding: const pw.EdgeInsets.all(4),
    child: pw.Text(text, style: pw.TextStyle(fontSize: 10)),
  );
}

pw.Widget _pdfRightAlignedContainer(String text) {
  return pw.Container(
    alignment: pw.Alignment.centerRight,
    padding: const pw.EdgeInsets.only(right: 4),
    child: pw.Text(text, style: pw.TextStyle(fontSize: 10)),
  );
}
