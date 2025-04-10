import 'package:billing/views/config/config_page.dart';
import 'package:billing/views/pdf_preview_page.dart';
import 'package:billing/views/table_editor_page.dart';
import 'package:billing/views/storage_page.dart'; // new import
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final NavigationController navController = Get.put(NavigationController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: navController.pageController,
        onPageChanged: (index) => navController.currentIndex.value = index,
        children: [
          const TableEditorPage(),
          const PDFPreviewPage(),
          ConfigPage(),
          StoragePage(), // New Page
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: navController.currentIndex.value,
          onTap: navController.changePage,
          items: [
            BottomNavigationBarItem(icon: const Icon(Icons.table_chart), label: "Table",backgroundColor: Theme.of(context).primaryColor),
            BottomNavigationBarItem(icon: Icon(Icons.picture_as_pdf), label: "PDF",backgroundColor: Theme.of(context).primaryColor),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Config",backgroundColor: Theme.of(context).primaryColor),
            BottomNavigationBarItem(icon: Icon(Icons.storage), label: "Storage",backgroundColor: Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final pageController = PageController(initialPage: 1);
  var currentIndex = 1.obs;

  void changePage(int index) {
    currentIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
