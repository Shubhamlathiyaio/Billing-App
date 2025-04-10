// lib/models/invoice_model.dart
import 'package:billing/models/invoice_item.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Invoice {
  int id = 0;

  // All fields are stored as String
  String invoiceNo;
  String date;
  String companyName;
  String address;
  String gstNumber;
  String panNumber;
  String stateCode;
  String billTaker;
  String billTakerAddress;
  String billTakerGSTPin;
  String userFirm;
  String userFirmAddress;
  String userFirmGSTPin;
  String broker;
  String discount;
  String othLess;
  String freight;
  String iGst;
  String sGst;
  String cGst;

  @Backlink()
  final items = ToMany<InvoiceItem>();

  Invoice({
    required this.invoiceNo,
    required this.date,
    required this.companyName,
    required this.address,
    required this.gstNumber,
    required this.panNumber,
    required this.stateCode,
    required this.billTaker,
    required this.billTakerAddress,
    required this.billTakerGSTPin,
    required this.userFirm,
    required this.userFirmAddress,
    required this.userFirmGSTPin,
    required this.broker,
    required this.discount,
    required this.othLess,
    required this.freight,
    required this.iGst,
    required this.sGst,
    required this.cGst,
  });
}
