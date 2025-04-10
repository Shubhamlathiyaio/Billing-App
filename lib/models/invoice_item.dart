// lib/models/invoice_item_model.dart
import 'package:billing/models/invoice.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class InvoiceItem {
  int id = 0;

  String chalan;
  String itemName;
  String quality;
  String quantity; // Store as String, convert to double when needed
  String rate;     // Store as String, convert to double when needed

  final invoice = ToOne<Invoice>();

  InvoiceItem({
    required this.chalan,
    required this.itemName,
    required this.quality,
    required this.quantity,
    required this.rate,
  });
}
