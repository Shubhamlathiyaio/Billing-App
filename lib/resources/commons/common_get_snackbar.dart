import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonSnackbar {
  static void show({
    required String title,
    required String message,
    Color backgroundColor = Colors.black54,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 2),
    SnackPosition position = SnackPosition.TOP,
    SnackStyle style = SnackStyle.FLOATING,
    double barBlur = 10,
    Icon? icon, // optional icon
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      colorText: textColor,
      duration: duration,
      barBlur: barBlur,
      snackPosition: position,
      snackStyle: style,
      messageText: Row(
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: icon,
            ),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: textColor),
            ),
          ),
        ],
      ),
    );
  }

  static noItemSnackbar() => show(
      title: "Error",
      message: "No items to save",
      icon: Icon(
        Icons.error,
        color: Colors.red,
      ));

  static errorSnackbar(String lable) => show(
      title: "Error",
      message: lable,
      icon: Icon(
        Icons.error,
        color: Colors.red,
      ));

  static successSnackbar(String label) => show(
        title: label,
        message: "Invoice $label successfully",
        icon: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 24,
        ),
      );
}
