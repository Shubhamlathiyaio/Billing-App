import 'package:billing/resources/media_query_helper.dart';
import 'package:billing/resources/widgets/pdf_incoice_body_part/pdf_billing_and_delivery_details.dart';
import 'package:billing/resources/widgets/pdf_incoice_body_part/pdf_invoice_details.dart';
import 'package:billing/resources/widgets/pdf_incoice_body_part/pdf_invoice_header.dart';
import 'package:billing/resources/widgets/pdf_incoice_body_part/pdf_invoice_items_table.dart';
import 'package:billing/resources/widgets/pdf_incoice_body_part/pdf_payment_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:get/get.dart';
import '../../controllers/config_controller.dart';
import '../../controllers/invoice_controller.dart';

pw.Widget pdfInvoiceBody(BuildContext context) {
  final configController = Get.find<ConfigController>();
  final invoiceController = Get.find<InvoiceController>();

    MediaQueryHelper media = MediaQueryHelper(context);
    double baseFontSize = media.screenWidth * 0.017;


  return pw.Container(
    padding: const pw.EdgeInsets.all(12),
    decoration: pw.BoxDecoration(
      border: pw.Border.all(width: 1),
    ),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // 🏢 Company Header
        pdfCompanyHeader(configController),

        pw.SizedBox(height: 10),

        // 🧾 Invoice Details
        pdfInvoiceDetails(configController, invoiceController),

        pw.SizedBox(height: 10),

        // 🧍 Billing & Delivery Details (Placeholder for now)
       pdfBillingAndDeliveryDetails(configController, invoiceController),

        pw.SizedBox(height: 10),

        // 📦 Item Table (Placeholder for now)
        pdfInvoiceItemsTable(),

        pw.SizedBox(height: 10),

        // 💳 Payment Summary (Placeholder for now)
        pdfPaymentSummary(baseFontSize, invoiceController),
      ],
    ),
  );
}
