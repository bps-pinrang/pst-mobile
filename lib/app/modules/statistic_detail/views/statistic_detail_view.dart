import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/enums/app_animation.dart';
import '../../../core/enums/button_size.dart';
import '../../../core/utils/helper.dart';
import '../../../core/utils/view_helper.dart';
import '../../../core/values/size.dart';
import '../../../global_widgets/app_button.dart';
import '../../../global_widgets/lottie_with_author.dart';
import '../../../global_widgets/shimmer_widget.dart';
import '../controllers/statistic_detail_controller.dart';
import '../../../../i18n/strings.g.dart';

class StatisticDetailView extends GetView<StatisticDetailController> {
  const StatisticDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(t.label.menu.statistics),
        surfaceTintColor: theme.canvasColor,
        scrolledUnderElevation: 10,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.share),
          )
        ],
      ),
      body: FooterLayout(
        footer: Container(
          padding: kPadding16,
          decoration: BoxDecoration(color: theme.canvasColor, boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(Get.isDarkMode ? 0.6 : 0.1),
              blurRadius: 6,
            )
          ]),
          child: Obx(
            () => AppButton.primary(
              buttonSize: ButtonSize.large,
              label: 'Unduh',
              isBusy: controller.isDownloadProcessing.value,
              onPressed: () => controller.handleDownload(
                url: controller.statisticTable.value?.excel ?? '',
                fileName: controller.statisticTable.value?.title ?? '',
                extension: 'xls',
              ),
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: kPadding16H8V,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: theme.colorScheme.primaryContainer,
                          child: ExtendedImage.asset(
                            'assets/logo/bps_icon.png',
                            width: 15,
                            height: 15,
                          ),
                        ),
                        horizontalSpace(4),
                        Text(
                          'BPS Kabupaten Pinrang',
                          style: textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Obx(
                          () => Expanded(
                            child: Text(
                              formatDate('EEEE, dd MMM yyyy',
                                  controller.statisticTable.value?.createdAt),
                              style: textTheme.caption,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        )
                      ],
                    ),
                    const Divider(),
                    Obx(
                      () {
                        if (controller.isLoading.value) {
                          return Column(
                            children: [
                              ShimmerWidget(width: Get.width, height: 10),
                              verticalSpace(8),
                              ShimmerWidget(width: Get.width, height: 10),
                              verticalSpace(8),
                              ShimmerWidget(width: Get.width, height: 10),
                            ],
                          );
                        }

                        if (controller.failure.value != null) {
                          final failure = controller.failure.value!;
                          return Column(
                            children: [
                              LottieWithAuthor(
                                title: failure.title,
                                message: '',
                                animation: AppAnimation.warning,
                                semanticLabel: failure.message,
                              ),
                              verticalSpace(16),
                              AppButton.primary(
                                buttonSize: ButtonSize.large,
                                isDense: true,
                                onPressed: controller.loadStatisticTableDetail,
                                label: 'Coba Lagi',
                              )
                            ],
                          );
                        }

                        final table = controller.statisticTable.value;
                        final htmlData = table!.table!
                            .replaceAll('&quot;', '"')
                            .replaceAll('quot;', '"')
                            .replaceAll('&nbsp;', '')
                            .replaceAll('&amp;', '&')
                            .replaceAll('&lt;', '<')
                            .replaceAll('&gt;', '>')
                            .replaceAll('\\r', '')
                            .replaceAll('<nobr>', '<p>')
                            .replaceAll('</nobr>', '</p>')
                            .replaceAll('<td style=""><p>&nbsp;</p></td>', '')
                            .replaceAll(
                                '<td style="font-family:Times New Roman;font-size:11px;color:#000000;font-weight:bold;">',
                                '<td style="font-family:Times New Roman;font-size:11px;color:#000000;font-weight:bold;" colspan="6">')
                            .replaceAll(
                                '<td style="font-family:Times New Roman;font-size:11px;color:#000000;">',
                                '<td style="font-family:Times New Roman;font-size:11px;color:#000000;" colspan="6">')
                            .replaceAll(
                                '<td style="font-family:Times New Roman;font-size:11px;color:#000000;font-style:italic;">',
                                '<td style="font-family:Times New Roman;font-size:11px;color:#000000;font-style:italic;" colspan="6">')
                            .replaceAll(
                                '<td style="font-family:Calibri;font-size:10px;color:#000000;">',
                                '<td style="font-family:Calibri;font-size:10px;color:#000000;" colspan="4">')
                            .replaceAll(
                                '<td style="font-family:Calibri;font-size:10px;color:#000000;font-style:italic;">',
                                '<td style="font-family:Calibri;font-size:10px;color:#000000;font-style:italic;" colspan="4">')
                            .replaceAll(
                                '<td style="font-family:Calibri;font-size:8px;color:#000000;">',
                                '<td style="font-family:Calibri;font-size:8px;color:#000000;" colspan="2">')
                            .replaceAll('\\n', '')
                            .replaceAll('\\t', '');
                        return SizedBox(
                          width: Get.width,
                          child: Scrollbar(
                            controller: controller.scrollController,
                            scrollbarOrientation: ScrollbarOrientation.top,
                            radius: const Radius.circular(10),
                            trackVisibility: true,
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                              controller: controller.scrollController,
                              scrollDirection: Axis.horizontal,
                              child: HtmlWidget(
                                htmlData,
                                renderMode: RenderMode.column,
                                textStyle: textTheme.caption,
                                isSelectable: true,
                                onTapUrl: (url) async {
                                  return await launchUrl(
                                    Uri.parse(url),
                                    mode: LaunchMode.externalApplication,
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
