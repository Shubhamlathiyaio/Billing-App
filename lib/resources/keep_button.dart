import 'package:billing/controllers/storage_controller.dart';
import 'package:billing/controllers/table_controller.dart';
import 'package:billing/resources/commons/common_get_snackbar.dart';
import 'package:billing/resources/media_query_helper.dart';
import 'package:billing/services/pdf_services.dart';
import 'package:billing/services/small_services.dart';
import 'package:billing/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeepStyleFAB extends StatefulWidget {
  const KeepStyleFAB({super.key});

  @override
  State<KeepStyleFAB> createState() => _KeepStyleFABState();
}

class _KeepStyleFABState extends State<KeepStyleFAB>
    with SingleTickerProviderStateMixin {
  bool isOpen = false;
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _opacityAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  void _toggleFab() {
    setState(() => isOpen = !isOpen);
    if (isOpen) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryHelper media = MediaQueryHelper(context);
    return SizedBox(
      width: media.screenWidth,
      height: media.screenHeight,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          _buildAnimatedOption(
            label: "Share",
            icon: Icons.share,
            onTap: () async {
              if (Get.find<TableController>().itemList.isEmpty) {
                CommonSnackbar.noItemSnackbar();
              } else {
                var unsavedInvoice =
                    Get.find<StorageController>().unsavedInvoice;
                final pdf = PdfServices.getPdfDoc(unsavedInvoice);
                PdfServices.sharePdf(pdf, getFileName(unsavedInvoice.id));
                Get.find<StorageController>().saveInvoice();
              }
              _toggleFab();
            },
            position: 4,
          ),
          _buildAnimatedOption(
            label: "Save",
            icon: Icons.save,
            onTap: () {
              if (Get.find<TableController>().itemList.isEmpty) {
                CommonSnackbar.noItemSnackbar();
              } else {
                Get.find<StorageController>().saveInvoice();
                Get.find<NavigationController>().changePage(3);
                Get.find<StorageController>().clearCurrentData();
                CommonSnackbar.customSuccessSnackbar("Saved");
              }
              _toggleFab();
            },
            position: 3,
          ),
          _buildAnimatedOption(
            label: "Download",
            icon: Icons.download,
            onTap: () {
              if (Get.find<TableController>().itemList.isEmpty) {
                CommonSnackbar.noItemSnackbar();
              } else {
                final unsavedInvoice = Get.find<StorageController>().unsavedInvoice;

                Get.find<StorageController>().saveInvoice();
                PdfServices.downloadPdf(PdfServices.getPdfDoc(unsavedInvoice),
                    getFileName(unsavedInvoice.id));
                CommonSnackbar.customSuccessSnackbar("Download");
              }
              _toggleFab();
            },
            position: 2,
          ),
          _buildAnimatedOption(
            label: "New Invoice",
            icon: Icons.add,
            onTap: () {
              Get.find<StorageController>().clearUnsavedInvoice();
              Get.find<NavigationController>().changePage(0);
              _toggleFab();
            },
            position: 1,
          ),
          FloatingActionButton(
            heroTag: 'mainFab',
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: _toggleFab,
            child: Icon(isOpen ? Icons.close : Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedOption({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    required int position,
  }) {
    final double slideOffset = 70.0 * position;

    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(0, 0.3),
        end: Offset(0, 0),
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(0.1 * position, 1.0, curve: Curves.easeOut),
        ),
      ),
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Padding(
          padding: EdgeInsets.only(bottom: slideOffset + 16, right: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(label, style: const TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 6),
              FloatingActionButton(
                heroTag: label,
                mini: true,
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: onTap,
                child: Icon(icon, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
