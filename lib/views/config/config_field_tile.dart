import 'package:flutter/material.dart';
import 'package:billing/models/config.dart';
import 'package:billing/resources/commons/common_text.dart';
import 'package:billing/resources/commons/common_text_field.dart';
import 'package:flutter/services.dart';

class ConfigFieldTile extends StatelessWidget {
  final ConfigField field;

  const ConfigFieldTile({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    if (field.type == ConfigFieldType.date) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              field.controller.text =
                  "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
            }
          },
          child: AbsorbPointer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(data: field.label, fontSize: 14),
                CommonTextField(
                    controller: field.controller, hintText: "Select Date"),
              ],
            ),
          ),
        ),
      );
    }

    if (field.type == ConfigFieldType.address) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(data: field.label, fontSize: 14),
            CommonTextField(
              controller: field.controller,
              hintText: "Enter address",
              maxLines: 3, // 👈 multi-line support
            ),
          ],
        ),
      );
    }

    if (field.type == ConfigFieldType.numCap) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(data: field.label, fontSize: 14),
            CommonTextField(
              controller: field.controller,
              hintText: "Enter GST number",
              textCapitalization: TextCapitalization.characters,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
              ],
            ),
          ],
        ),
      );
    }

    if (field.type == ConfigFieldType.mobile) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(data: field.label, fontSize: 14),
            CommonTextField(
              controller: field.controller,
              hintText: "Enter mobile number",
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(data: field.label, fontSize: 14),
          CommonTextField(
            controller: field.controller,
            keyboardType: field.type == ConfigFieldType.number
                ? TextInputType.number
                : TextInputType.text,
          ),
        ],
      ),
    );
  }
}
