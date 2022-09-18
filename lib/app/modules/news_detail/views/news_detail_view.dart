import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:pst_online/app/core/enums/app_animation.dart';
import 'package:pst_online/app/core/enums/button_size.dart';
import 'package:pst_online/app/core/utils/helper.dart';
import 'package:pst_online/app/core/utils/view_helper.dart';
import 'package:pst_online/app/core/values/size.dart';
import 'package:pst_online/app/global_widgets/app_button.dart';
import 'package:pst_online/app/global_widgets/app_network_image.dart';
import 'package:pst_online/app/global_widgets/lottie_with_author.dart';
import 'package:pst_online/app/global_widgets/shimmer_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/news_detail_controller.dart';
import '../../../../i18n/strings.g.dart';

class NewsDetailView extends GetView<NewsDetailController> {
  const NewsDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(t.label.menu.news),
        surfaceTintColor: theme.canvasColor,
        scrolledUnderElevation: 10,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.share),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () {
                if(controller.isLoading.value) {
                  return ShimmerWidget(width: Get.width, height: Get.height * 0.3);
                }

                return AppNetworkImage(
                  url: controller.news.value?.picture ?? '',
                  width: Get.width,
                  height: Get.height * 0.3,
                  borderRadius: BorderRadius.circular(0),
                );
              },
            ),
            Padding(
              padding: kPadding16H8V,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () {
                      if (controller.isLoading.value) {
                        return Column(
                          children: [
                            ShimmerWidget(width: Get.width, height: 16),
                            verticalSpace(8),
                            ShimmerWidget(width: Get.width, height: 16),
                            verticalSpace(8),
                            ShimmerWidget(width: Get.width, height: 16),
                          ],
                        );
                      }

                      if (controller.failure.value != null) {
                        return const Text('-');
                      }

                      final news = controller.news.value;
                      return Text(
                        news?.title ?? '-',
                        style: textTheme.displaySmall,
                      );
                    },
                  ),
                  verticalSpace(8),
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
                                controller.news.value?.releaseDate),
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
                              message: failure.message,
                              animation: AppAnimation.warning,
                              semanticLabel: failure.message,
                            ),
                            verticalSpace(16),
                            AppButton.primary(
                              buttonSize: ButtonSize.large,
                              isDense: true,
                              onPressed: controller.loadNewsDetail,
                              label: 'Coba Lagi',
                            )
                          ],
                        );
                      }

                      final news = controller.news.value;
                      final htmlData = news!.news
                          .replaceAll('&quot;', '"')
                          .replaceAll('quot;', '"')
                          .replaceAll('&amp;', '&')
                          .replaceAll('&lt;', '<')
                          .replaceAll('&gt;', '>');
                      return HtmlWidget(
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
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
