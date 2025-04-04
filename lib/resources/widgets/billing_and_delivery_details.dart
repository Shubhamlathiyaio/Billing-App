import 'package:billing/commons/common_container.dart';
import 'package:billing/commons/common_spacing.dart';
import 'package:billing/commons/common_text.dart';
import 'package:billing/controllers/config_controller.dart';
import 'package:billing/controllers/invoice_controller.dart';
import 'package:billing/resources/constens.dart';
import 'package:billing/resources/media_query_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Widget billingAndDeliveryDetails(double baseFontSize, MediaQueryHelper media) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _headerRow(baseFontSize),
      _detailsRow(baseFontSize),
      _brokerInfo(baseFontSize, media),
    ],
  );
}

Widget _headerRow(double baseFontSize) {
  return Row(
    children: [
      _headerContainer("Billing Details", baseFontSize, rightBorder: LINEWIDTH / 2),
      _headerContainer("Delivery Address", baseFontSize, leftBorder: LINEWIDTH / 2),
    ],
  );
}

Widget _headerContainer(String title, double baseFontSize, {double leftBorder = 0, double rightBorder = 0}) {
  return Expanded(
    child: CommonContainer(
      horizontalBorder: LINEWIDTH,
      leftBorder: leftBorder,
      rightBorder: rightBorder,
      padding: const EdgeInsets.symmetric(horizontal: PADDING),
      child: CommonText(
        data: title,
        fontSize: baseFontSize * MEDIUM,
      ),
    ),
  );
}

Widget _detailsRow(double baseFontSize) {
    final configController = Get.find<ConfigController>();

  return Row(
    children: [
      _detailsContainer(
        title: "M/S.: ${configController.billTaker.value}",
        address: configController.billTakerAddress.value,
        gstPin: configController.billTakerGSTPin.value,
        baseFontSize: baseFontSize,
        rightBorder: LINEWIDTH / 2,
      ),
      _detailsContainer(
        title: configController.userFirm.value,
        address: configController.userFirmAddress.value,
        gstPin: configController.userFirmGSTPin.value,
        baseFontSize: baseFontSize,
        leftBorder: LINEWIDTH / 2,
      ),
    ],
  );
}

Widget _detailsContainer({
  required String title,
  required String address,
  required String gstPin,
  required double baseFontSize,
  double leftBorder = 0,
  double rightBorder = 0,
}) {
  return Expanded(
    child: CommonContainer(
      padding: const EdgeInsets.symmetric(horizontal: PADDING),
      leftBorder: leftBorder,
      rightBorder: rightBorder,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(data: title, fontSize: baseFontSize * MEDIUM),
          SizedBox(
            height: baseFontSize * 5,
            width: baseFontSize * 30,
            child: CommonText(
              data: address,
              fontSize: baseFontSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          CommonText(
            data: "GST PIN: $gstPin",
            fontSize: baseFontSize,
            fontWeight: FontWeight.normal,
          ),
        ],
      ),
    ),
  );
}

Widget _brokerInfo(double baseFontSize, MediaQueryHelper media) {
  final invoiceController = Get.find<InvoiceController>();

  return CommonContainer(
    width: media.screenWidth,
    topBorder: LINEWIDTH,
    padding: const EdgeInsets.symmetric(vertical: PADDING, horizontal: PADDING),
    child: CommonText(
      data: "Broker: ${invoiceController.broker.value}",
      fontSize: baseFontSize,
    ),
  );
}
