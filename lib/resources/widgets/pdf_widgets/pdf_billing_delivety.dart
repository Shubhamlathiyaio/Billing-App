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
  return pw.Row(
    children: [
      _detailsContainer(
        title: "M/S.: ${invoice.billTaker}",
        address: invoice.billTakerAddress,
        gstPin: invoice.billTakerGSTPin,
        baseFontSize: baseFontSize,
        rightBorder: 0.5,
      ),
      _detailsContainer(
        title: invoice.deliveryFirm.trim().isEmpty
            ? "Firm of Delivery"
            : invoice.deliveryFirm,
        address: invoice.deliveryFirmAddress,
        gstPin: invoice.deliveryFirmGSTPin,
        baseFontSize: baseFontSize,
        leftBorder: 0.5,
      ),
    ],
  );
}

pw.Widget _detailsContainer({
  required String title,
  required String address,
  required String gstPin,
  required double baseFontSize,
  double leftBorder = 0,
  double rightBorder = 0,
}) {
  return pw.Expanded(
    child: PDFContainer(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8),
      leftBorder: leftBorder,
      rightBorder: rightBorder,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          PDFText(data: title, fontSize: baseFontSize * 1.2),
          pw.SizedBox(height: 2),
          pw.Container(
            height: baseFontSize * 4.5,
            child: PDFText(
              data: address,
              fontSize: baseFontSize,
              fontWeight: pw.FontWeight.normal,
            ),
          ),
          pw.SizedBox(height: 2),
          PDFText(
            data: "GST PIN: $gstPin",
            fontSize: baseFontSize,
            fontWeight: pw.FontWeight.normal,
          ),
        ],
      ),
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
