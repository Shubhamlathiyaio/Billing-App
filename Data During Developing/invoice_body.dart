import 'package:billing/resources/commons/common_container.dart';
import 'package:billing/controllers/config_controller.dart';
import 'invoice_controller.dart';
import 'package:billing/resources/constens.dart';
import 'package:billing/resources/media_query_helper.dart';
import 'invoice_body_part/billing_and_delivery_details.dart';
import 'invoice_body_part/company_header.dart';
import 'invoice_body_part/invoice_details.dart';
import 'invoice_body_part/invoice_items_table.dart';
import 'invoice_body_part/payment_summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget invoiceBody(BuildContext context) {
    final configController = Get.find<ConfigController>();
  final invoiceController = Get.find<InvoiceController>();
  MediaQueryHelper media = MediaQueryHelper(context);
  double x = (media.screenWidth - 20) / 47;
  double baseFontSize = media.screenWidth * 0.017; // Updated base font size

  return Center(
    child: CommonContainer(
      width: media.screenWidth - 20,
      height: (media.screenWidth - 20) * A4RATIO,
      allBorder: LINEWIDTH,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section (Company Name, Address)
            companyHeader(baseFontSize, media, configController),

            // Invoice Details
            invoiceDetails(baseFontSize, configController, invoiceController),

            // // Billing & Delivery Section
            billingAndDeliveryDetails(baseFontSize, media),

            // // Table of Items
            invoiceItemsTable(baseFontSize, x),

            // // Payment Details & Summary
            paymentSummary(baseFontSize, MediaQueryData(), invoiceController),
          ],
        ),
      ),
    ),
  );
}
