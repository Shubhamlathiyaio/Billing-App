import 'package:billing/commons/common_spacing.dart';
import 'package:billing/resources/media_query_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billing/controllers/bill_controller.dart';
import 'package:billing/commons/common_button.dart';
import 'package:billing/commons/common_text.dart';
import 'package:billing/commons/common_text_field.dart'; // ✅ Import CommonTextField

class BillScreen extends StatelessWidget {
  final BillController controller = Get.put(BillController());

  @override
  Widget build(BuildContext context) {
    final media = MediaQueryHelper(context);

    return Scaffold(
      appBar: AppBar(title: CommonText(data: "Billing", fontSize: 24)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: media.screenWidth * 0.05, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextField(controller: controller.itemController,label: "Item Name"), // ✅ Replaced TextField

            h16,
            CommonTextField(controller: controller.priceController,label: "Price", keyboardType: TextInputType.number), // ✅ Replaced TextField

            h24,
            CommonButton(
              onPressed: () async {
                await controller.exportToPDF();
                controller.goToPreview();
              },
              text: "Export & Preview PDF 📄",
            ),
          ],
        ),
      ),
    );
  }
}
