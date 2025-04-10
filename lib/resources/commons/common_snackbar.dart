import 'package:billing/resources/commons/common_text.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> CommonSnackbar(
    BuildContext context, String data) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: CommonText(data: data,fontColor: Colors.white,),
    behavior: SnackBarBehavior.floating,
  ));
}
