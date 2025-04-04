import 'package:billing/commons/common_container.dart';
import 'package:billing/controllers/config_controller.dart';
import 'package:billing/controllers/invoice_controller.dart';
import 'package:billing/resources/constens.dart';
import 'package:billing/resources/media_query_helper.dart';
import 'package:billing/resources/widgets/billing_and_delivery_details.dart';
import 'package:billing/resources/widgets/company_header.dart';
import 'package:billing/resources/widgets/invoice_details.dart';
import 'package:billing/resources/widgets/invoice_items_table.dart';
import 'package:billing/resources/widgets/payment_summary.dart';
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
