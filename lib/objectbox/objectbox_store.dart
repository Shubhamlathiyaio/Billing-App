// lib/objectbox/objectbox_store.dart
import 'package:billing/models/invoice.dart';
import 'package:billing/models/invoice_item.dart';
import 'package:billing/objectbox.g.dart';

class ObjectBoxStore {
  late final Store store;
  late final Box<Invoice> invoiceBox;
  late final Box<InvoiceItem> itemBox;

  ObjectBoxStore._create(this.store) {
    invoiceBox = Box<Invoice>(store);
    itemBox = Box<InvoiceItem>(store);
  }

  static Future<ObjectBoxStore> init() async {
    final store = await openStore();
    return ObjectBoxStore._create(store);
  }
}
