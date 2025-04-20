import 'package:get_storage/get_storage.dart';

class AppStorage {
  static final box = GetStorage();
  static const String _lastInvoiceIdKey = 'last_invoice_id';

  static void saveLastInvoiceId(int id) {
    box.write(_lastInvoiceIdKey, id);
  }

  static int getLastInvoiceId() {
    return box.read(_lastInvoiceIdKey) ?? 0;
  }
}
