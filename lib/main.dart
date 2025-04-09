import 'package:billing/controllers/config_controller.dart';
import 'package:billing/controllers/preview_controller.dart';
import 'package:billing/controllers/table_ceontroller.dart';
import 'package:billing/models/config.dart';
import 'package:billing/services/splash_screen.dart';
import 'package:billing/views/config_page.dart';
import 'package:billing/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Initialize local storage
  Get.put(ConfigController());
  Get.put(ConfigExpansionController());
  // Get.put(InvoiceController());
  Get.put(PreviewController());
  Get.put(TableController()).loadItemsFromStorage();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      builder: FlutterSmartDialog.init(),
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/splash', page: () => const SplashScreen()),
        // GetPage(name: '/', page: () => InvoiceTemplate()),
        // GetPage(name: '/preview', page: () => PreviewPage()),
        GetPage(name: '/config', page: () => ConfigPage()),
      ],
    );
  }
}
