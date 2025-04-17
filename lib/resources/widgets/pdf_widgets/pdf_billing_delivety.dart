import 'package:billing/models/invoice.dart';
import 'package:billing/resources/widgets/common_pdfs/pdf_conatiner.dart';
import 'package:billing/resources/widgets/common_pdfs/pdf_text.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget billingAndDeliveryDetailsPdf(
    double baseFontSize, double pageWidth, Invoice invoice) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _headerRow(baseFontSize),
      _detailsRow(baseFontSize, invoice),
      _brokerInfo(baseFontSize, pageWidth, invoice),
    ],
  );
}

pw.Widget _headerRow(double baseFontSize) {
  return pw.Row(
    children: [
      _headerContainer("Billing Details", baseFontSize, rightBorder: 0.5),
      _headerContainer("Delivery Address", baseFontSize, leftBorder: 0.5),
    ],
  );
}

pw.Widget _headerContainer(String title, double baseFontSize,
    {double leftBorder = 0, double rightBorder = 0}) {
  return pw.Expanded(
    child: PDFContainer(
      horizontalBorder: 1,
      leftBorder: leftBorder,
      rightBorder: rightBorder,
      padding: const pw.EdgeInsets.symmetric(horizontal: 8),
      child: PDFText(
        data: title,
        fontSize: baseFontSize * 1.2,
      ),
    ),
  );
}

pw.Widget _detailsRow(double baseFontSize, Invoice invoice) {
  final commonPadding = const pw.EdgeInsets.symmetric(horizontal: 8);
  final boxHeight = baseFontSize * 8.5;

  return pw.Row(
    children: [
      // Left Box - Bill Taker
      pw.Expanded(
        child: pw.Container(
          height: boxHeight,
          decoration: pw.BoxDecoration(
            border: pw.Border(right: pw.BorderSide(width: 0.5)),
          ),
          padding: commonPadding,
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Title and Address
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _labelAndData("M/S.:", invoice.billTaker, baseFontSize * 1.2),
                  pw.SizedBox(height: 2),
                  _labelAndData("Address:", invoice.billTakerAddress, baseFontSize - baseFontSize * 0.08),
                ],
              ),
              // Mobile and GST
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _labelAndData("Mobile no:", invoice.billTakerMobileNo, baseFontSize),
                  pw.SizedBox(height: 2),
                  _labelAndData("GST PIN:", invoice.billTakerGSTPin, baseFontSize),
                ],
              )
            ],
          ),
        ),
      ),

      // Right Box - Delivery Firm
      pw.Expanded(
        child: pw.Container(
          height: boxHeight,
          decoration: pw.BoxDecoration(
            border: pw.Border(left: pw.BorderSide(width: 0.5)),
          ),
          padding: commonPadding,
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Title and Address
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _labelAndData("Delivery Firm :", invoice.deliveryFirm, baseFontSize * 1.2),
                  pw.SizedBox(height: 2),
                  _labelAndData("Address:", invoice.deliveryFirmAddress, baseFontSize - baseFontSize * 0.08),
                ],
              ),
              // Mobile
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _labelAndData("Mobile no:", invoice.deliveryFirmMobileNo, baseFontSize),
                ],
              )
            ],
          ),
        ),
      ),
    ],
  );
}

pw.Widget _labelAndData(String label, String? data, double fontSize) {
  return pw.RichText(
    text: pw.TextSpan(
      children: [
        pw.TextSpan(
          text: "$label ",
          style: pw.TextStyle(fontSize: fontSize, fontWeight: pw.FontWeight.bold),
        ),
        if (data != null && data.trim().isNotEmpty)
          pw.TextSpan(
            text: data,
            style: pw.TextStyle(fontSize: fontSize, fontWeight: pw.FontWeight.normal),
          ),
      ],
    ),
  );
}


pw.Widget _brokerInfo(double baseFontSize, double width, Invoice invoice) {
  return PDFContainer(
    width: width,
    topBorder: 1,
    padding: const pw.EdgeInsets.symmetric(vertical: 1, horizontal: 8),
    child: PDFText(
      data: "Broker: ${invoice.broker}",
      fontSize: baseFontSize,
    ),
  );
}
