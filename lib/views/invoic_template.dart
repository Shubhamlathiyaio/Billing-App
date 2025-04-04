import 'package:billing/commons/common_box_decoration.dart';
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
const double LINEWIDTH = 1;
const double PADDING = 3;
const double A4RATIO = 1.414;

class InvoiceTemplate extends StatelessWidget {
  InvoiceTemplate({super.key});

  final configController = Get.find<ConfigController>();
  final invoiceController = Get.find<InvoiceController>();

  @override
  Widget build(BuildContext context) {
    final media = MediaQueryHelper(context);
    double baseFontSize = media.screenWidth * 0.017; // Updated base font size

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
    double baseFontSize = media.screenWidth * 0.017; // Updated base font size
    return Center(
      child: CommonContainer(
        width: media.screenWidth - 20,
        height: (media.screenWidth - 20) * A4RATIO,
        allBorder: LINEWIDTH,
        child: SingleChildScrollView(
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CommonText(
                      data: configController.companyName.value,
                      fontSize: baseFontSize * LARGE,
                    ),
                  ),
                  Center(
                    child: CommonText(
                      data: configController.address.value,
                      fontSize: baseFontSize,
                      maxLines: 2,
                    ),
                  ),
                  Center(
                    child: CommonContainer(
                      centerAlign: true,
                      width: media.screenWidth,
                      horizontalBorder: LINEWIDTH,
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
                        padding: EdgeInsets.symmetric(horizontal: PADDING),
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
                        leftBorder: LINEWIDTH,
                        padding: EdgeInsets.symmetric(horizontal: PADDING),
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
                        child: CommonContainer(
                          horizontalBorder: LINEWIDTH,
                          rightBorder: LINEWIDTH / 2,
                          padding: EdgeInsets.symmetric(horizontal: PADDING),
                          child: CommonText(
                            data: "Billing Details",
                            fontSize: baseFontSize,
                          ),
                        ),
                      ),
                      Expanded(
                        child: CommonContainer(
                          horizontalBorder: LINEWIDTH,
                          leftBorder: LINEWIDTH / 2,
                          padding: EdgeInsets.symmetric(horizontal: PADDING),
                          child: CommonText(
                            data: "Delivery Address",
                            fontSize: baseFontSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CommonContainer(
                          padding: EdgeInsets.symmetric(horizontal: PADDING),
                          rightBorder: LINEWIDTH / 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                data:
                                    "M/S.: ${configController.billTaker.value}",
                                fontSize: baseFontSize,
                              ),
                              SizedBox(
                                height: baseFontSize * 5,
                                width: 100,
                                child: CommonText(
                                  data: configController.billTakerAddress.value,
                                  fontSize: baseFontSize,
                                ),
                              ),
                              CommonText(
                                data:
                                    "GST PIN: ${configController.billTakerGSTPin.value}",
                                fontSize: baseFontSize,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: CommonContainer(
                          padding: EdgeInsets.symmetric(horizontal: PADDING),
                          leftBorder: LINEWIDTH / 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                data: configController.userFirm.value,
                                fontSize: baseFontSize,
                              ),
                              SizedBox(
                                height: baseFontSize * 5,
                                width: baseFontSize * 30,
                                child: CommonText(
                                  data: configController.userFirmAddress.value,
                                  fontSize: baseFontSize,
                                ),
                              ),
                              CommonText(
                                data:
                                    "GST PIN: ${configController.userFirmGSTPin.value}",
                                fontSize: baseFontSize,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  CommonContainer(
                    width: media.screenWidth,
                    topBorder: LINEWIDTH,
                    padding: EdgeInsets.only(
                        top: PADDING, left: PADDING, right: PADDING),
                    child: CommonText(
                      data: "Broker: ${invoiceController.broker.value}",
                      fontSize: baseFontSize,
                    ),
                  ),
                  h8,
                  Table(
                    columnWidths: {
                      0: IntrinsicColumnWidth(),
                      1: FlexColumnWidth(),
                      2: FixedColumnWidth(media.screenWidth * (.14 + .01)),
                      3: FixedColumnWidth(media.screenWidth * (.14 - .03)),
                      4: FixedColumnWidth(media.screenWidth * (.14 - .01)),
                      5: FixedColumnWidth(media.screenWidth * (.14 - .03)),
                      6: FixedColumnWidth(media.screenWidth * (.14 + .01)),
                    },
                    border: TableBorder(
                        verticalInside:
                            BorderSide(width: 1, color: Colors.black)),
                    children: [
                      TableRow(
                        decoration: CommonBoxDecoration.ui(
                            horizontalBorderWidth: LINEWIDTH),
                        children: [
                          for (var header in [
                            "Sr No",
                            "Description",
                            "Quality",
                            "HSN Code",
                            "Qty",
                            "Rate",
                            "Amount"
                          ])
                            Padding(
                              padding: EdgeInsets.all(PADDING),
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
                                    7,
                                    (i) => Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: CommonText(
                                              data: " ",
                                              fontSize: baseFontSize * 0.9),
                                        )),
                              )),
                      TableRow(
                          decoration: CommonBoxDecoration.ui(
                              horizontalBorderWidth: LINEWIDTH),
                          children: [
                            SizedBox.shrink(),
                            CommonContainer(
                              alignment: Alignment.center,
                              child: CommonText(
                                  fontWeight: FontWeight.normal,
                                  data: "Sub Total",
                                  fontSize: baseFontSize),
                            ),
                            SizedBox.shrink(),
                            SizedBox.shrink(),
                            CommonContainer(
                              alignment: Alignment.center,
                              child: CommonText(
                                fontWeight: FontWeight.normal,
                                data: "00.00",
                                fontSize: baseFontSize,
                              ),
                            ),
                            SizedBox.shrink(),
                            CommonContainer(
                              padding: EdgeInsets.only(right: PADDING),
                              alignment: Alignment.centerRight,
                              child: CommonText(
                                fontWeight: FontWeight.normal,
                                data: "00.00",
                                fontSize: baseFontSize,
                              ),
                            ),
                          ])
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 28,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: PADDING),
                              child: CommonContainer(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText(
                                      data: "Bank", fontSize: baseFontSize),
                                  CommonText(
                                      data: "Branc", fontSize: baseFontSize),
                                  CommonText(
                                      data: "A/C", fontSize: baseFontSize),
                                  CommonText(
                                      data: "IFSC", fontSize: baseFontSize),
                                ],
                              )),
                            ),
                            CommonContainer(
                              height: A4RATIO * media.screenWidth * .05,
                              topBorder: LINEWIDTH,
                              alignment: Alignment.bottomLeft,
                              padding:
                                  EdgeInsets.symmetric(horizontal: PADDING),
                              child: CommonText(
                                data: "Remark:",
                                fontSize: baseFontSize,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 19,
                        child: CommonContainer(
                          padding: EdgeInsets.symmetric(horizontal: PADDING),
                          leftBorder: LINEWIDTH,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tile(
                                  "Discount",
                                  "-",
                                  invoiceController.discount.value,
                                  00.00,
                                  baseFontSize),
                              tile("Oth Less", "-", "", 00.00, baseFontSize),
                              tile("Freight", "+", "", 00.00, baseFontSize),
                              tile(
                                  "Taxable Value", "", "", 00.00, baseFontSize),
                              tile("I GST", "+", "", 00.00, baseFontSize),
                              tile("S GST", "+", "", 00.00, baseFontSize),
                              tile("C GST", "+", "", 00.00, baseFontSize),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  CommonContainer(
                    horizontalBorder: LINEWIDTH,
                    padding: EdgeInsets.symmetric(horizontal: PADDING),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          data: "DueDays: ",
                          fontSize: baseFontSize * MEDIUM,
                        ),
                        CommonText(
                          data: "Due Date: ",
                          fontSize: baseFontSize * MEDIUM,
                        ),
                        CommonText(
                          data: "Net Amount: \t",
                          fontSize: baseFontSize * MEDIUM,
                        ),
                      ],
                    ),
                  ),
                  CommonContainer(
                      padding: EdgeInsets.symmetric(horizontal: PADDING),
                      horizontalBorder: LINEWIDTH,
                      child: CommonText(
                        data: "Amount In Words : .",
                        fontSize: baseFontSize * MEDIUM,
                      )),
                  termsAndConditon(baseFontSize, media),
                ],
              )),
        ),
      ),
    );
  }

  Widget termsAndConditon(double baseFontSize,MediaQueryHelper media) {
    return CommonContainer(
      padding: EdgeInsets.symmetric(horizontal: PADDING),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  data: "Terms and Conditions:-",
                  fontSize: baseFontSize * MEDIUM,
                  fontWeight: FontWeight.bold,
                ),
                for (var (i, term) in [
                  "Complaint, if any, regarding this Invoice must be settled immediately.",
                  "Goods once sold will not be taken back or exchanged.",
                  "Goods are dispatched to the account and risk of the buyer.",
                  "Interest @2% per month will be charged on the amount remaining unpaid from the due date.",
                  "Subject to SURAT Jurisdiction."
                ].indexed)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                            data: "${i + 1})",
                            fontSize: baseFontSize), // Bullet point
                        Expanded(
                          child: CommonText(data: term, fontSize: baseFontSize - (baseFontSize/.5)),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
              child: CommonContainer(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                data: "data",
                fontSize: baseFontSize * MEDIUM,
              ),
              SizedBox(height: media.screenWidth*A4RATIO*.1),
              CommonText(
                  data: "Auth. Sign.",
                  fontSize: baseFontSize)
            ],
          )))
        ],
      ),
    );
  }

  Widget tile(
      String title, String sy, String per, double amount, double baseFontSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          data: title,
          fontSize: baseFontSize,
        ),
        CommonText(
          data: sy,
          fontSize: baseFontSize,
        ),
        CommonText(
          data: per.isNotEmpty ? "$per %" : "",
          fontSize: baseFontSize,
        ),
        CommonText(
          data: amount.toStringAsFixed(2),
          fontSize: baseFontSize,
        ),
      ],
    );
  }
}
