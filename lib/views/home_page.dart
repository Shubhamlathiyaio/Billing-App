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
          PdfPreviewPage(),
          ConfigPage(),
          StoragePage(), // New Page
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar( type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
          currentIndex: navController.currentIndex.value,
          selectedItemColor: Colors.white,
          unselectedItemColor: Theme.of(context).colorScheme.secondary,
          onTap: navController.changePage,
          items: [
            BottomNavigationBarItem(icon: const Icon(Icons.table_chart), label: "Table",backgroundColor: Colors.white),
            BottomNavigationBarItem(icon: Icon(Icons.picture_as_pdf), label: "PDF",backgroundColor: Colors.white),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Config",backgroundColor: Colors.white),
            BottomNavigationBarItem(icon: Icon(Icons.storage), label: "Storage",backgroundColor: Colors.white),
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
