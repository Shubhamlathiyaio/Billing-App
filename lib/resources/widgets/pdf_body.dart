import 'package:billing/controllers/config_controller.dart';
import 'package:billing/resources/constens.dart';
import 'package:billing/resources/widgets/pdf_widgets/pdf_billing_delivety.dart';
import 'package:billing/resources/widgets/pdf_widgets/pdf_details.dart';
import 'package:billing/resources/widgets/pdf_widgets/pdf_header.dart';
import 'package:billing/resources/widgets/pdf_widgets/pdf_invoice_table.dart';
import 'package:billing/resources/widgets/pdf_widgets/pdf_payment.dart';
import 'package:billing/resources/widgets/pdf_widgets/pdf_terms_summary.dart';
import 'package:pdf/widgets.dart';

Widget invoiceBodyPdf(
  ConfigController config,
  double screenWidth,
  int id,
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
          companyHeaderPdf(baseFontSize, screenWidth, config),
          invoiceDetailsPdf(baseFontSize, screenWidth, height, config),
          billingAndDeliveryDetailsPdf(baseFontSize, screenWidth, config),
          invoiceItemsTablePdf(baseFontSize, x),
          paymentSummaryPdf(baseFontSize),
          termsAndConditionsSectionPdf(baseFontSize),
        ],
      ),
    ),
  );
}
