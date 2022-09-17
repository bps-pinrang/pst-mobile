import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:pst_online/app/global_widgets/shimmer_widget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../controllers/pdf_reader_controller.dart';

class PdfReaderView extends GetView<PdfReaderController> {
  const PdfReaderView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () {
            if (controller.title.value.isEmpty) {
              return ShimmerWidget(width: Get.width * 0.8, height: 12);
            }

            return Text(controller.title.value);
          },
        ),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (controller.url.value.isEmpty) {
            return Center(
              child: SpinKitFadingCircle(
                color: theme.primaryColor,
                size: 30,
              ),
            );
          }

          return SfPdfViewer.network(
            controller.url.value,
            enableTextSelection: true,
            enableDoubleTapZooming: true,
            enableHyperlinkNavigation: true,
            canShowHyperlinkDialog: true,
            canShowPaginationDialog: true,
            canShowScrollHead: true,
            canShowScrollStatus: true,
            interactionMode: PdfInteractionMode.selection,
          );
        },
      ),
    );
  }
}
