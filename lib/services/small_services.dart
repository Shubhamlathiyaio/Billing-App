import 'package:billing/controllers/table_controller.dart';
import 'package:billing/resources/colors.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

String getTodayDate() {
  final now = DateTime.now();
  return '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
}

String generateNextInvoiceNo(String? lastInvoiceNo) {
  if (lastInvoiceNo == null || lastInvoiceNo.isEmpty) return '001';

  final number = int.tryParse(lastInvoiceNo.replaceAll(RegExp(r'\D'), '')) ?? 0;
  return (number + 1).toString().padLeft(3, '0');
}

String perOf(double per, double amount) =>
    ((per / 100) * amount).toStringAsFixed(2);

double rxStringToDouble(RxString value) {
  return double.tryParse(value.value) ?? 0.0;
}

String getAmountInWords(int amount) {
  return amount == 0
      ? ""
      : '${NumberToWord().convert('en-in', amount).toUpperCase()} ONLY';
}

// font = await loadGujaratiFont();
Future<pw.Font> loadGujaratiFont() async {
  final fontData = await rootBundle
      .load("assets/fonts/NotoSansGujarati-VariableFont_wdth,wght.ttf");
  return pw.Font.ttf(fontData);
}

String getFileName(int id) => "Invo_${id}_${getDate(DateTime.now())}";
String getDate(DateTime date) => "${date.day}/${date.month}/${date.year}";

List<int> chalanNos = [];
Color getColor(int index) {
  if (Get.find<TableController>().itemList.isEmpty) chalanNos = [];
  if (!chalanNos.contains(index)) chalanNos.add(index);
  return chalanColors[chalanNos.indexOf(index)];
}

PdfColor getPdfColor(int index) {
  if (!chalanNos.contains(index)) chalanNos.add(index);
  return chalanPdfColors[chalanNos.indexOf(index)];
}
