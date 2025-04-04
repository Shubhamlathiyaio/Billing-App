import 'package:billing/commons/common_container.dart';
import 'package:billing/commons/common_text.dart';
import 'package:billing/resources/constens.dart';
import 'package:billing/resources/media_query_helper.dart';
import 'package:flutter/material.dart';

Widget companyHeader(double baseFontSize, MediaQueryHelper media, dynamic configController) {
  return Column(
    children: [
      Center(
        child: CommonText(
          data: configController.companyName.value,
          fontSize: baseFontSize * LARGE,
        ),
      ),
      Center(
        child: CommonText(
          data: configController.address.value,
          fontSize: baseFontSize,
          maxLines: 2,
        ),
      ),
      CommonContainer(
        centerAlign: true,
        width: media.screenWidth,
        horizontalBorder: LINEWIDTH,
        child: CommonText(
          data: "Invoice",
          fontSize: baseFontSize * MEDIUM,
        ),
      ),
    ],
  );
}
