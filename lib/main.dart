import 'package:billing/controllers/config_controller.dart';
import 'package:billing/controllers/preview_controller.dart';
import 'package:billing/controllers/table_controller.dart';
import 'package:billing/models/config.dart';
import 'package:billing/views/splash_screen.dart';
import 'package:billing/views/config/config_page.dart';
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
  Get.put(NavigationController());
  Get.put(PreviewController());
  Get.put(TableController()).loadItemsFromStorage();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF4B6587),      // Muted blue
      secondary: const Color(0xFF8DA9C4),    // Soft light blue
      background: const Color(0xFFF7F9FC),   // Very light grey
      surface: const Color(0xFFFFFFFF),      // Cards, tiles
      onPrimary: Colors.white,
      onSecondary: Colors.black87,
      onBackground: Colors.black87,
      onSurface: Colors.black87,
    ),
    scaffoldBackgroundColor: const Color(0xFFF7F9FC),
    appBarTheme:  AppBarTheme(
      backgroundColor: Color(0xFF4B6587),
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4B6587),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
    useMaterial3: true,
  ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      builder: FlutterSmartDialog.init(),
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/config', page: () => ConfigPage()),
      ],
    );
  }
}
