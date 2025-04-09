import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ConfigFieldType { text, number, date }

class ConfigField {
  final String label;
  final TextEditingController controller;
  final ConfigFieldType type;

  ConfigField({
    required this.label,
    required this.controller,
    this.type = ConfigFieldType.text,
  });
}


class ConfigGroup {
  final String title;
  final List<ConfigField> fields;

  ConfigGroup({required this.title, required this.fields});
}

class ConfigExpansionController extends GetxController {
  RxInt openTileIndex = (-1).obs;

  void toggleTile(int index) {
    if (openTileIndex.value == index) {
      openTileIndex.value = -1; // collapse
    } else {
      openTileIndex.value = index; // open the new one
    }
  }
}
