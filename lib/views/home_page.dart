import 'package:billing/views/config_page.dart';
import 'package:billing/views/pdf_preview_page.dart';
import 'package:billing/views/table_editor_page.dart';
import 'package:flutter/material.dart';

  final pageController = PageController(initialPage: 1);
class HomePage extends StatelessWidget {
   HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(controller: pageController,
        children: [
          ConfigPage(),
          PDFPreviewPage(),
          TableEditorPage(),
        ],
      ),
    );
  }
}