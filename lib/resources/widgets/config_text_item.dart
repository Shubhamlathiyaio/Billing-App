import 'package:billing/commons/common_spacing.dart';
import 'package:billing/commons/common_text.dart';
import 'package:billing/commons/common_text_field.dart';
import 'package:flutter/material.dart';

class ConfigItemWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  ConfigItemWidget({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(data: label),
        CommonTextField(controller: controller),
        h16,
      ],
    );
  }
}
