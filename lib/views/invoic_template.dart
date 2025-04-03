import 'package:billing/commons/common_spacing.dart';
import 'package:billing/commons/common_text.dart';
import 'package:billing/controllers/config_controller.dart';
import 'package:billing/controllers/invoice_controller.dart';
import 'package:billing/resources/media_query_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class InvoiceTemplate extends StatelessWidget {
  final configController = Get.find<ConfigController>();
  final invoiceController = Get.find<InvoiceController>();

  @override
  Widget build(BuildContext context) {
    final media = MediaQueryHelper(context);
    double baseFontSize = media.screenWidth * 0.02; // Scales text proportionally

    return Scaffold(
      appBar: AppBar(
        title: CommonText(data: "Billing"),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/config');
            },
            icon: Icon(Icons.deblur),
          ),
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          width: media.screenWidth - 20,
          height: (media.screenWidth - 20) * 1.414, // Maintain A4 ratio
          decoration: BoxDecoration(border: Border.all(width: 2)),
          child: SingleChildScrollView(
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CommonText(
                        data: configController.companyName.value,
                        fontSize: baseFontSize * 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Center(
                      child: CommonText(
                        data: configController.address.value,
                        fontSize: baseFontSize * 1.2,
                      ),
                    ),
                    Divider(),
                    Center(
                      child: CommonText(
                        data: "Invoice",
                        fontSize: baseFontSize * 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              data: "GST No: ${configController.gstNumber.value}",
                              fontSize: baseFontSize,
                            ),
                            CommonText(
                              data: "PAN No: ${configController.panNumber.value}",
                              fontSize: baseFontSize,
                            ),
                            CommonText(
                              data: "State Code: ${configController.stateCode.value}",
                              fontSize: baseFontSize,
                            ),
                          ],
                        ),
                        VerticalDivider(thickness: 2, width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              data: "Invoice No: ${invoiceController.invoiceNo.value}",
                              fontSize: baseFontSize,
                            ),
                            CommonText(
                              data: "Date: ${invoiceController.date.value}",
                              fontSize: baseFontSize,
                            ),
                            CommonText(
                              data: "Challan No: ${invoiceController.challanNo.value}",
                              fontSize: baseFontSize,
                            ),
                          ],
                        ),
                      ],
                    ),
                    h16,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              data: "Billing Details",
                              fontSize: baseFontSize * 1.2,
                            ),
                            CommonText(
                              data: invoiceController.billTaker.value,
                              fontSize: baseFontSize,
                            ),
                            CommonText(
                              data: invoiceController.billTakerAddress.value,
                              fontSize: baseFontSize,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              data: "Delivery Address",
                              fontSize: baseFontSize * 1.2,
                            ),
                            CommonText(
                              data: invoiceController.userFirm.value,
                              fontSize: baseFontSize,
                            ),
                            CommonText(
                              data: invoiceController.userFirmAddress.value,
                              fontSize: baseFontSize,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    CommonText(
                      data: "Broker: ${invoiceController.broker.value}",
                      fontSize: baseFontSize,
                    ),
                    Divider(),
                    Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(
                          children: [
                            CommonText(data: "Sr No", fontSize: baseFontSize),
                            CommonText(data: "Description", fontSize: baseFontSize),
                            CommonText(data: "HSN Code", fontSize: baseFontSize),
                            CommonText(data: "Qty", fontSize: baseFontSize),
                            CommonText(data: "Rate", fontSize: baseFontSize),
                            CommonText(data: "Amount", fontSize: baseFontSize),
                          ],
                        ),
                        ...invoiceController.items.map(
                          (item) => TableRow(
                            children: [
                              CommonText(data: item.srNo, fontSize: baseFontSize * 0.9),
                              CommonText(data: item.description, fontSize: baseFontSize * 0.9),
                              CommonText(data: item.hsnCode, fontSize: baseFontSize * 0.9),
                              CommonText(data: item.qty, fontSize: baseFontSize * 0.9),
                              CommonText(data: item.rate, fontSize: baseFontSize * 0.9),
                              CommonText(data: item.amount, fontSize: baseFontSize * 0.9),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    CommonText(
                      data: "Subtotal: ${invoiceController.netAmount.value}",
                      fontSize: baseFontSize,
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(data: "Bank: ${invoiceController.bank.value}", fontSize: baseFontSize),
                            CommonText(data: "A/C: ${invoiceController.accountNo.value}", fontSize: baseFontSize),
                            CommonText(data: "IFSC: ${invoiceController.ifsc.value}", fontSize: baseFontSize),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(data: "Discount: ${invoiceController.discount.value}", fontSize: baseFontSize),
                            CommonText(data: "Taxable Value: ${invoiceController.taxableValue.value}", fontSize: baseFontSize),
                            CommonText(data: "Final Total: ${invoiceController.finalTotal.value}", fontSize: baseFontSize * 1.2, fontWeight: FontWeight.bold),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    CommonText(
                      data: "Amount in Words: ${invoiceController.amountInWords.value}",
                      fontSize: baseFontSize,
                    ),
                    Divider(),
                    CommonText(
                      data: "Terms & Conditions:",
                      fontSize: baseFontSize * 1.1,
                    ),
                    CommonText(
                      data: invoiceController.terms.value,
                      fontSize: baseFontSize,
                    ),
                  ],
                )),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          invoiceController.exportToPDF();
        },
        child: Icon(Icons.preview),
      ),
    );
  }
}
