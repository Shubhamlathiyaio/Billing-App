import 'dart:convert';
import 'dart:io';

import 'package:billing/models/invoice.dart';
import 'package:csv/csv.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> exportInvoicesToCsv(List<Invoice> invoices) async {
  final List<List<dynamic>> rows = [];

  // Add version info at the top
  rows.add(['version', '2.0.0']);

  // Add headers (adjust according to your Invoice model)
  rows.add([
    'id',
    // Company
    'companyName',
    'address',
    // Invoice
    'gstNumber',
    'mobileNo',
    // 'panNumber',
    'stateCode',
    'invoiceNo',
    'date',
    // Billing Details
    'billTaker',
    'billTakerAddress',
    'billTakerMobileNo',
    'billTakerGSTPin',
    // 'deliveryFirm',
    // 'deliveryFirmAddress',
    // 'deliveryFirmMobileNo',
    // 'deliveryFirmGSTPin',
    'broker',
    // Bank Details
    'bankName',
    'bankBranch',
    'bankAccountNo',
    'bankIFSCCode',
    'remark',
    // Discounts and Charges
    'discount',
    'othLess',
    'freight',
    'iGst',
    'sGst',
    'cGst',
    [
      'chalan',
      'itemName',
      'taka',
      'hsnCode',
      'qty',
      'rate',
    ],
  ]);

  // Add invoice data
  for (var invoice in invoices) {
    rows.add([
      invoice.id,
      // Company
      invoice.companyName,
      invoice.address,
      // Invoice
      invoice.gstNumber,
      invoice.mobileNo,
      // invoice.panNumber,
      invoice.stateCode,
      invoice.invoiceNo,
      invoice.date,
      // Billing Details
      invoice.billTaker,
      invoice.billTakerAddress,
      invoice.billTakerMobileNo,
      invoice.billTakerGSTPin,
      // invoice.deliveryFirm,
      // invoice.deliveryFirmAddress,
      // invoice.deliveryFirmMobileNo,
      // invoice.deliveryFirmGSTPin,
      invoice.broker,
      // Bank Details
      invoice.bankName,
      invoice.bankBranch,
      invoice.bankAccountNo,
      invoice.bankIFSCCode,
      invoice.remark,
      // Discounts and Charges
      invoice.discount,
      invoice.othLess,
      invoice.freight,
      invoice.iGst,
      invoice.sGst,
      invoice.cGst,
      invoice.rawItemsJson
    ]);
  }

  // Convert to CSV string
  String csv = const ListToCsvConverter().convert(rows);
await Permission.storage.request();
final directory = Directory('/storage/emulated/0/Download/BillingApp');

if (!(await directory.exists())) {
  await directory.create(recursive: true);  
}

final file = File('${directory.path}/invo_v1${DateTime.now().millisecond}.csv');
await file.writeAsString(csv, encoding: const Utf8Codec());

}