  // lib/models/invoice_item_model.dart
  import 'package:billing/models/invoice.dart';
  import 'package:objectbox/objectbox.dart';

  @Entity()
  class InvoiceItem {
    int id = 0;

    String chalan;
    String itemName;
    String taka;
    String hsnCode;
    String qty; // Store as String, convert to double when needed
    String rate; // Store as String, convert to double when needed

    final invoice = ToOne<Invoice>(); // Relation to Invoice

    InvoiceItem({
      required this.chalan,
      required this.itemName,
      required this.taka,
      required this.hsnCode,
      required this.qty,
      required this.rate,
    });

    InvoiceItem copyWith({
  String? chalan,
  String? itemName,
  String? taka,
  String? hsnCode,
  String? qty,
  String? rate,
}) {
  return InvoiceItem(
    chalan: chalan ?? this.chalan,
    itemName: itemName ?? this.itemName,
    taka: taka ?? this.taka,
    hsnCode: hsnCode ?? this.hsnCode,
    qty: qty ?? this.qty,
    rate: rate ?? this.rate,
  );
}


    // Convert the object to JSON format for external use
    Map<String, dynamic> toJson() => {
          'chalan': chalan,
          'itemName': itemName,
          'taka': taka,
          'hsnCode': hsnCode,
          'qty': qty,
          'rate': rate,
        };

    // Factory to create an InvoiceItem from JSON
    factory InvoiceItem.fromJson(Map<String, dynamic> json) => InvoiceItem(
          chalan: json['chalan'] ?? '',
          itemName: json['itemName'] ?? '',
          taka: json['taka'] ?? '',
          hsnCode: json['hsnCode'] ?? '',
          qty: json['qty'] ?? '0',
          rate: json['rate'] ?? '0',
        );

    @override
    String toString() {
      return 'InvoiceItem{id: $id, chalan: $chalan, itemName: $itemName, taka: $taka, hsnCode: $hsnCode, qty: $qty, rate: $rate}';
    }
  }
