import 'package:get/get.dart';

import '../controllers/pdf_reader_controller.dart';

class PdfReaderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PdfReaderController>(
      () => PdfReaderController(),
    );
  }
}
