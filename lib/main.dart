import 'package:billing/controllers/config_controller.dart';
import 'package:billing/controllers/invoice_controller.dart';
import 'package:billing/controllers/preview_controller.dart';
import 'package:billing/services/config_page.dart';
import 'package:billing/views/invoic_template.dart';
import 'package:billing/views/previewPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Initialize local storage
  Get.put(ConfigController());
  Get.put(InvoiceController());
  Get.put(PreviewController());
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        // GetPage(name: '/', page: () => BillScreen()),
        GetPage(name: '/', page: () => InvoiceTemplate()),
        GetPage(name: '/preview', page: () => PreviewPage()),
        GetPage(name: '/config', page: () => ConfigPage()),
      ],
    );
  }
}
