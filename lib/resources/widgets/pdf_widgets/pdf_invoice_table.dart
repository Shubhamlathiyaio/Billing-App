import 'package:billing/controllers/table_controller.dart';
import 'package:billing/models/table_item.dart';
import 'package:billing/resources/widgets/common_pdfs/pdf_text.dart';
import 'package:billing/services/small_services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget invoiceItemsTablePdf(double baseFontSize, double pageWidth) {
  final items = Get.find<TableController>().itemList;
  final TableController table = Get.find<TableController>();

  final int minRows = 15;
  final int emptyRowsNeeded = (minRows - items.length - 2).clamp(0, 100);

  return pw.Container(
    decoration: const pw.BoxDecoration(
      border: pw.Border(
        top: pw.BorderSide(width: 1),
        bottom: pw.BorderSide(width: 1),
        left: pw.BorderSide(width: 0.5),
        right: pw.BorderSide(width: 0.5),
      ),
    ),
    child: pw.Table(
      border: const pw.TableBorder(
        verticalInside: pw.BorderSide(width: 0.5),
      ),
      columnWidths: _getPdfColumnWidths(pageWidth),
      children: [
        _buildHeaderRow(baseFontSize),
        ...items.asMap().entries.map((entry) {
          final i = entry.key + 1;
          final item = entry.value;
          return _buildItemRow(i, item, baseFontSize);
        }),
        ...List.generate(emptyRowsNeeded, (_) => _buildEmptyRow(baseFontSize)),
        _buildSubTotalRow(baseFontSize, table),
      ],
    ),
  );
}

pw.TableRow _buildItemRow(int index, TableItem item, double baseFontSize) {
  final amount = item.qty * item.rate;
  final color = getPdfColor(item.chalanNo);
  return pw.TableRow(
    children: [
      _centeredCell(index.toString(), baseFontSize, color),
      _centeredCell(item.chalanNo.toString(), baseFontSize, color, ),
      _leftAlignedCell(item.itemName, baseFontSize, color),
      _centeredCell(item.taka.toString(), baseFontSize, color),
      _centeredCell(item.hsnCode, baseFontSize, color),
      _centeredCell(item.qty.toString(), baseFontSize, color),
      _centeredCell(item.rate.toStringAsFixed(2), baseFontSize, color),
      _rightAlignedCell(amount.toStringAsFixed(2), baseFontSize, color),
    ],
  );
}

Map<int, pw.TableColumnWidth> _getPdfColumnWidths(double width) {
  return {
    0: pw.FixedColumnWidth(width * 0.08),
    1: pw.FixedColumnWidth(width * 0.095),
    2: pw.FixedColumnWidth(width * 0.26),
    3: pw.FixedColumnWidth(width * 0.12),
    4: pw.FixedColumnWidth(width * 0.10), 
    5: pw.FixedColumnWidth(width * 0.10),
    6: pw.FixedColumnWidth(width * 0.12),
    7: pw.FixedColumnWidth(width * 0.12),
  };
}

pw.TableRow _buildHeaderRow(double baseFontSize) {
  final headers = [
    "Sr No",
    "Chal No",
    "Description",
    "Quality",
    "HSN",
    "Qty",
    "Rate",
    "Amount"
  ];
  return pw.TableRow(
    decoration: const pw.BoxDecoration(
      border: pw.Border(
        bottom: pw.BorderSide(width: 0.5), // 🔽 Line under header
      ),
    ),
    children: headers
        .map(
          (header) => pw.Padding(
            padding: const pw.EdgeInsets.all(6),
            child: PDFText(
              data: header,
              fontSize: baseFontSize * 1.1,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        )
        .toList(),
  );
}

pw.TableRow _buildEmptyRow(double baseFontSize) {
  return pw.TableRow(
    children: List.generate(
      8,
      (_) => pw.Container(
        height: baseFontSize * 1.8, // 👈 Increase this to make the row taller
        padding: const pw.EdgeInsets.all(6),
        child: PDFText(data: " ", fontSize: baseFontSize),
      ),
    ),
  );
}

pw.TableRow _buildSubTotalRow(double baseFontSize, TableController table) {
  return pw.TableRow(
    decoration: const pw.BoxDecoration(
      border: pw.Border(top: pw.BorderSide(width: 0.5)),
    ),
    children: [
      pw.SizedBox(),
      pw.SizedBox(),
      _centeredCell("Sub Total", baseFontSize),
      pw.SizedBox(),
      pw.SizedBox(),
      _centeredCell(table.totalQuantity.toStringAsFixed(2), baseFontSize),
      pw.SizedBox(),
      _rightAlignedCell(table.subTotal.toStringAsFixed(2), baseFontSize),
    ],
  );
}

pw.Widget _centeredCell(String text, double fontSize,[PdfColor color = PdfColors.black]) {
  return pw.Container(
    alignment: pw.Alignment.center,
    child: PDFText(data: text, fontSize: fontSize, fontColor: color),
  );
}

pw.Widget _leftAlignedCell(String text, double fontSize,[PdfColor color = PdfColors.black]) {
  return pw.Container(
    alignment: pw.Alignment.centerLeft,
    padding: const pw.EdgeInsets.only(left: 6),
    child: PDFText(data: text, fontSize: fontSize, fontColor: color),
  );
}

pw.Widget _rightAlignedCell(String text, double fontSize,[PdfColor color = PdfColors.black]) {
  return pw.Container(
    alignment: pw.Alignment.centerRight,
    padding: const pw.EdgeInsets.only(right: 6),
    child: PDFText(data: text, fontSize: fontSize,  fontColor: color),
  );
}
