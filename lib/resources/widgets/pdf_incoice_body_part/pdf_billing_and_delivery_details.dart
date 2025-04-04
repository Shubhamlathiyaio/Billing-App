import 'package:billing/controllers/config_controller.dart';
import 'package:billing/controllers/invoice_controller.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget pdfBillingAndDeliveryDetails(ConfigController configController, InvoiceController invoiceController) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _pdfHeaderRow(),
      _pdfDetailsRow(configController),
      _pdfBrokerInfo(invoiceController),
    ],
  );
}

pw.Widget _pdfHeaderRow() {
  return pw.Row(
    children: [
      _pdfHeaderContainer("Billing Details", rightBorder: 0.5),
      _pdfHeaderContainer("Delivery Address", leftBorder: 0.5),
    ],
  );
}

pw.Widget _pdfHeaderContainer(String title, {double leftBorder = 0, double rightBorder = 0}) {
  return pw.Expanded(
    child: pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.symmetric(horizontal: pw.BorderSide(width: 1)),
      ),
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    ),
  );
}

pw.Widget _pdfDetailsRow(ConfigController configController) {
  return pw.Row(
    children: [
      _pdfDetailsContainer(
        title: "M/S.: ${configController.billTaker.value}",
        address: configController.billTakerAddress.value,
        gstPin: configController.billTakerGSTPin.value,
        rightBorder: 0.5,
      ),
      _pdfDetailsContainer(
        title: configController.userFirm.value,
        address: configController.userFirmAddress.value,
        gstPin: configController.userFirmGSTPin.value,
        leftBorder: 0.5,
      ),
    ],
  );
}

pw.Widget _pdfDetailsContainer({
  required String title,
  required String address,
  required String gstPin,
  double leftBorder = 0,
  double rightBorder = 0,
}) {
  return pw.Expanded(
    child: pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 2),
          pw.Text(
            address,
            style: pw.TextStyle(fontSize: 10),
          ),
          pw.SizedBox(height: 2),
          pw.Text(
            "GST PIN: $gstPin",
            style: pw.TextStyle(fontSize: 10),
          ),
        ],
      ),
    ),
  );
}

pw.Widget _pdfBrokerInfo(InvoiceController invoiceController) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border(top: pw.BorderSide(width: 1)),
    ),
    padding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    child: pw.Text(
      "Broker: ${invoiceController.broker.value}",
      style: pw.TextStyle(fontSize: 10),
    ),
  );
}
