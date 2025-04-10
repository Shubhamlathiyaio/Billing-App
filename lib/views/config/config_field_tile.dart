import 'package:flutter/material.dart';
import 'package:billing/models/config.dart';
import 'package:billing/resources/commons/common_text.dart';
import 'package:billing/resources/commons/common_text_field.dart';

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
              field.controller.text = picked.toString().split(" ").first;
            }
          },
          child: AbsorbPointer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(data: field.label, fontSize: 14),
                CommonTextField(controller: field.controller, hintText: "Select Date"),
              ],
            ),
          ),
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
            keyboardType: field.type == ConfigFieldType.number ? TextInputType.number : TextInputType.text,
            textCapitalization: TextCapitalization.characters,
          ),
        ],
      ),
    );
  }
}
