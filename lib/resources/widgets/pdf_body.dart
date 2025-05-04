import 'package:billing/resources/constens.dart';
import 'package:billing/resources/widgets/pdf_widgets/pdf_billing_delivety.dart';
import 'package:billing/resources/widgets/pdf_widgets/pdf_details.dart';
import 'package:billing/resources/widgets/pdf_widgets/pdf_header.dart';
import 'package:billing/resources/widgets/pdf_widgets/pdf_invoice_table.dart';
import 'package:billing/resources/widgets/pdf_widgets/pdf_payment.dart';
import 'package:billing/resources/widgets/pdf_widgets/pdf_terms_summary.dart';
import 'package:pdf/widgets.dart';
import 'package:billing/models/invoice.dart';

Widget invoiceBodyPdf(
  Invoice invoice,
  double screenWidth,
) {
  final double x = (screenWidth - 20) / 47;
  final double baseFontSize = screenWidth * 0.016;
  final double height = (screenWidth - 20) * A4RATIO;

  return Center(
    child: Container(
      width: screenWidth - 20,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(width: LINEWIDTH),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          companyHeaderPdf(baseFontSize, screenWidth, invoice),
          invoiceDetailsPdf(baseFontSize, screenWidth, height, invoice),
          billingAndDeliveryDetailsPdf(baseFontSize, screenWidth, invoice),
          invoiceItemsTablePdf(baseFontSize, x, invoice),
          paymentSummaryPdf(baseFontSize, invoice),
          termsAndConditionsSectionPdf(baseFontSize),
        ],
      ),
    ),
  );
}
