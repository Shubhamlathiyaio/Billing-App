import 'package:billing/commons/common_container.dart';
import 'package:billing/commons/common_spacing.dart';
import 'package:billing/commons/common_text.dart';
import 'package:billing/controllers/config_controller.dart';
import 'package:billing/controllers/invoice_controller.dart';
import 'package:billing/resources/media_query_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const double LARGE = 2;
const double MEDIUM = 1.5;
const double SMALL = 1.2;

class InvoiceTemplate extends StatelessWidget {
  final configController = Get.find<ConfigController>();
  final invoiceController = Get.find<InvoiceController>();


  @override
  Widget build(BuildContext context) {
    final media = MediaQueryHelper(context);
    double baseFontSize = media.screenWidth * 0.02; // Updated base font size

    return Scaffold(
      appBar: AppBar(
        title: CommonText(data: "Billing"),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/config');
            },
            icon: Icon(Icons.settings), // Updated icon
          ),
        ],
      ),
      body: invoiceBody(context),
      floatingActionButton: FloatingActionButton(
          onPressed: () => invoiceController.exportToPDF(),
          child: Icon(Icons.preview)),
    );
  }

  Widget invoiceBody(BuildContext context) {
    final media = MediaQueryHelper(context);
    double baseFontSize = media.screenWidth * 0.02; // Updated base font size
    return Center(
      child: Container(
        width: media.screenWidth - 20,
        height: (media.screenWidth - 20) * 1.414,
        decoration: BoxDecoration(border: Border.all(width: 2)),
        child: SingleChildScrollView(
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CommonText(
                      data: configController.companyName.value,
                      fontSize: baseFontSize * LARGE,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Center(
                    child: CommonText(
                      data: configController.address.value,
                      fontSize: baseFontSize * SMALL,
                      maxLines: 2,
                    ),
                  ),
                  Center(
                    child: CommonContainer(
                      centerAlign: true,
                      width: media.screenWidth,
                      verticalBorderWidth: 2,
                      child: CommonText(
                        data: "Invoice",
                        fontSize: baseFontSize * MEDIUM,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              data:
                                  "GST No: ${configController.gstNumber.value}",
                              fontSize: baseFontSize,
                            ),
                            CommonText(
                              data:
                                  "PAN No: ${configController.panNumber.value}",
                              fontSize: baseFontSize,
                            ),
                            CommonText(
                              data:
                                  "State Code: ${configController.stateCode.value}",
                              fontSize: baseFontSize,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Spacer(),
                      CommonContainer(
                        leftBorderWidth: 2,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              data:
                                  "Invoice No: ${invoiceController.invoiceNo.value}",
                              fontSize: baseFontSize,
                            ),
                            CommonText(
                              data: "Date: ${invoiceController.date.value}",
                              fontSize: baseFontSize,
                            ),
                            CommonText(
                              data:
                                  "Challan No: ${invoiceController.challanNo.value}",
                              fontSize: baseFontSize,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CommonContainer(verticalBorderWidth: 2,rightBorderWidth: 1,padding: EdgeInsets.symmetric(horizontal: 5),
                          child: CommonText(
                            data: "Billing Details",
                            fontSize: baseFontSize * SMALL,
                          ),
                        ),
                      ),
                      Expanded(
                        child: CommonContainer(verticalBorderWidth: 2,leftBorderWidth: 1,padding: EdgeInsets.symmetric(horizontal: 5),
                          child: CommonText(
                            data: "Delivery Address",
                            fontSize: baseFontSize * SMALL,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CommonContainer(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          rightBorderWidth: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                data: "M/S.: ${configController.billTaker.value}",
                                fontSize: baseFontSize,
                              ),
                              CommonText(
                                data: configController.billTakerAddress.value,
                                fontSize: baseFontSize,
                              ),
                              CommonText(
                                data: "GST PIN: ${configController.billTakerGSTPin.value}",
                                fontSize: baseFontSize,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: CommonContainer(
                           padding: EdgeInsets.symmetric(horizontal: 5),
                           leftBorderWidth: 1,
                           child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  data: configController.userFirm.value,
                                  fontSize: baseFontSize,
                                ),
                                CommonText(
                                  data: configController.userFirmAddress.value,
                                  fontSize: baseFontSize,
                                ),
                                CommonText(
                                  data: "GST PIN: $configController.userFirmGSTPin.value}",
                                  fontSize: baseFontSize,
                                ),
                              ],
                            ),
                            ),
                      ),
                    ],
                  ),
                  CommonText(
                    data: "Broker: ${invoiceController.broker.value}",
                    fontSize: baseFontSize,
                  ),
                  h8,
                  Table(
                    border: TableBorder(
                        verticalInside:
                            BorderSide(width: 1, color: Colors.black)),
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                            border: Border.symmetric(
                                horizontal: BorderSide(width: 2))),
                        children: [
                          for (var header in [
                            "Sr No",
                            "Description",
                            "HSN Code",
                            "Qty",
                            "Rate",
                            "Amount"
                          ])
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CommonText(
                                data: header,
                                fontSize: baseFontSize,
                                textAlign: TextAlign.center,
                              ),
                            ),
                        ],
                      ),
                      ...List.generate(
                          5,
                          (index) => TableRow(
                                children: List.generate(
                                    6,
                                    (i) => Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: CommonText(
                                              data: " ",
                                              fontSize: baseFontSize * 0.9),
                                        )),
                              )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                              data: "Bank: ${invoiceController.bank.value}",
                              fontSize: baseFontSize),
                          CommonText(
                              data: "A/C: ${invoiceController.accountNo.value}",
                              fontSize: baseFontSize),
                          CommonText(
                              data: "IFSC: ${invoiceController.ifsc.value}",
                              fontSize: baseFontSize),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                              data:
                                  "Discount: ${invoiceController.discount.value}",
                              fontSize: baseFontSize),
                          CommonText(
                              data:
                                  "Taxable Value: ${invoiceController.taxableValue.value}",
                              fontSize: baseFontSize),
                          CommonText(
                              data:
                                  "Final Total: ${invoiceController.finalTotal.value}",
                              fontSize: baseFontSize * SMALL,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
