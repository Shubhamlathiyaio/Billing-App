import 'package:billing/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:pdf/pdf.dart';

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
  return '${NumberToWord().convert('en-in', amount).toUpperCase()} ONLY';
}

List<int> chalanNo = [];
Color getColor(int index) {
  if (!chalanNo.contains(index)) chalanNo.add(index);
  return chalanColors[chalanNo.indexOf(index)];
}

PdfColor getPdfColor(int index) {
  if (!chalanNo.contains(index)) chalanNo.add(index);
  return chalanPdfColors[chalanNo.indexOf(index)];
}
