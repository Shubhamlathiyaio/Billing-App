  import 'package:billing/views/billin_screen.dart';
import 'package:billing/views/preview_screen.dart';
  import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

  void main() {
    WidgetsFlutterBinding.ensureInitialized();
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
        GetPage(name: '/', page: () => BillScreen()),
        GetPage(name: '/preview', page: () => PreviewScreen()),
      ],
    );
    }
  }
