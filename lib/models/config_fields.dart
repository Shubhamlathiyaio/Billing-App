import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigField {
  final TextEditingController controller;
  final RxString value;

  ConfigField({required this.controller}) : value = ''.obs;

  void load(String? savedValue) {
    controller.text = savedValue ?? '';
    value.value = controller.text;
    print("Loaded value: $savedValue");
  }

  void updateValue() {
    value.value = controller.text;
    print("Updated value: ${value.value}");
  }

  void dispose() {
    controller.dispose();
  }
}
