import 'package:get/get.dart';

class PreviewController extends GetxController {
  var pdfPath = "".obs;

  void setPdfPath(String path) {
    pdfPath.value = path;
  }
}
