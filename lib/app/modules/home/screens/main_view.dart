// ignore_for_file: invalid_use_of_protected_member

import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pst_online/app/core/enums/app_icon.dart';
import 'package:pst_online/app/core/enums/app_logo.dart';
import 'package:pst_online/app/core/enums/button_size.dart';
import 'package:pst_online/app/core/enums/button_variant.dart';
import 'package:pst_online/app/core/extensions/custom_color.dart';
import 'package:pst_online/app/core/utils/view_helper.dart';
import 'package:pst_online/app/core/values/color.dart';
import 'package:pst_online/app/core/values/size.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:pst_online/app/global_widgets/alert_variant.dart';
import 'package:pst_online/app/global_widgets/app_button.dart';
import 'package:pst_online/app/global_widgets/coming_soon.dart';
import 'package:pst_online/app/global_widgets/menu_button.dart';
import 'package:pst_online/app/global_widgets/theme_toggle_button.dart';
import 'package:pst_online/app/global_widgets/unauthenticated_placeholder.dart';
import 'package:pst_online/app/routes/app_pages.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../global_widgets/shimmer_widget.dart';
import '../controllers/home_controller.dart';
import '../../../../i18n/strings.g.dart';

class MainView extends GetView<HomeController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final extensionColor = Theme.of(context).extension<CustomColors>();
    return Scaffold(
      body: CustomScrollView(
        controller: controller.scrollController,
        slivers: [
          SliverAppBar(
            title: FadeInLeft(
              duration: 1.seconds,
              child: ExtendedImage.asset(
                AppLogo.pstH.value,
                height: 60,
                semanticLabel: t.semantics.pstLogo,
              ),
            ),
            floating: false,
            pinned: true,
            surfaceTintColor: theme.canvasColor,
            actions: [
              FadeInRight(
                delay: 500.milliseconds,
                child: IconButton(
                  onPressed: () {
                    showBottomSheetDialog(
                      context: context,
                      content: const ComingSoon(),
                    );
                  },
                  icon: Icon(
                    LineIcons.search,
                    size: 30,
                    semanticLabel: t.semantics.btn.search,
                  ),
                ),
              ),
              FadeInRight(
                child: const ThemeToggleButton(),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(8),
                Obx(
                  () => _buildBannerSection(theme),
                ),
                verticalSpace(8),
                Center(
                  child: Obx(
                    () => _buildPageIndicatorSection(),
                  ),
                ),
                Padding(
                  padding: kPadding16H8V,
                  child: Text(
                    'Menu',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onBackground,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                AnimationLimiter(
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: kPadding16,
                    children: [
                      AnimationConfiguration.staggeredGrid(
                        position: 0,
                        columnCount: 3,
                        duration: 1.seconds,
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: MenuButton(
                              icon: AppIcon.publication,
                              bgColor: theme.colorScheme.errorContainer,
                              textColor: theme.colorScheme.onErrorContainer,
                              label: t.label.menu.publication(count: 2),
                              onTap: () {
                                Get.toNamed(Routes.publications);
                              },
                            ),
                          ),
                        ),
                      ),
                      AnimationConfiguration.staggeredGrid(
                        position: 1,
                        columnCount: 3,
                        duration: 1.seconds,
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: MenuButton(
                              icon: AppIcon.data,
                              label: t.label.menu.data_table,
                              bgColor: theme.colorScheme.primaryContainer,
                              textColor: theme.colorScheme.onPrimaryContainer,
                              onTap: () {
                                showBottomSheetDialog(
                                  context: context,
                                  content: const ComingSoon(),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      AnimationConfiguration.staggeredGrid(
                        position: 2,
                        columnCount: 3,
                        duration: 1.seconds,
                        child: SlideAnimation(
                          verticalOffset: 50,
                          child: FadeInAnimation(
                            child: MenuButton(
                              icon: AppIcon.statistic,
                              label: t.label.menu.statistics,
                              bgColor: extensionColor?.successContainer,
                              textColor: extensionColor?.onSuccessContainer,
                              onTap: () {
                                showBottomSheetDialog(
                                  context: context,
                                  content: const ComingSoon(),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      AnimationConfiguration.staggeredGrid(
                        position: 3,
                        columnCount: 3,
                        duration: 1.seconds,
                        child: SlideAnimation(
                          verticalOffset: 50,
                          child: FadeInAnimation(
                            child: MenuButton(
                              icon: AppIcon.news,
                              label: t.label.menu.news,
                              bgColor: extensionColor?.warningContainer,
                              textColor: extensionColor?.onWarningContainer,
                              onTap: () {
                                showBottomSheetDialog(
                                  context: context,
                                  content: const ComingSoon(),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      AnimationConfiguration.staggeredGrid(
                        position: 4,
                        columnCount: 3,
                        duration: 1.seconds,
                        child: SlideAnimation(
                          verticalOffset: 50,
                          child: FadeInAnimation(
                            child: MenuButton(
                              icon: AppIcon.callCenter,
                              label: t.label.menu.live_chat,
                              bgColor: theme.colorScheme.errorContainer,
                              textColor: theme.colorScheme.onErrorContainer,
                              onTap: () {
                                final user = controller.user.value;
                                if (user != null) {
                                  Get.toNamed(
                                    Routes.liveChat,
                                    arguments: {
                                      kFormKeyEmail: user.email,
                                      kFormKeyName: user.name,
                                    },
                                  );
                                } else {
                                  showBottomSheetDialog(
                                    context: context,
                                    content: const UnauthenticatedPlaceholder(),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      AnimationConfiguration.staggeredGrid(
                        position: 5,
                        columnCount: 3,
                        duration: 1.seconds,
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: MenuButton(
                              icon: AppIcon.appointment,
                              bgColor: theme.colorScheme.primaryContainer,
                              textColor: theme.colorScheme.onPrimaryContainer,
                              label: t.label.menu.book_appointment,
                              onTap: () {
                                final user = controller.user.value;
                                if (user != null) {
                                  showBottomSheetDialog(
                                    context: context,
                                    content: const ComingSoon(),
                                  );
                                } else {
                                  showBottomSheetDialog(
                                    context: context,
                                    content: const UnauthenticatedPlaceholder(),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      AnimationConfiguration.staggeredGrid(
                        position: 6,
                        columnCount: 3,
                        duration: 1.seconds,
                        child: SlideAnimation(
                          verticalOffset: 50,
                          child: FadeInAnimation(
                            child: MenuButton(
                              icon: AppIcon.release,
                              label: t.label.menu.official_statistics_news,
                              bgColor: theme.colorScheme.errorContainer,
                              textColor: theme.colorScheme.onErrorContainer,
                              onTap: () {
                                showBottomSheetDialog(
                                  context: context,
                                  content: const ComingSoon(),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      AnimationConfiguration.staggeredGrid(
                        position: 7,
                        columnCount: 3,
                        duration: 1.seconds,
                        child: SlideAnimation(
                          verticalOffset: 50,
                          child: FadeInAnimation(
                            child: MenuButton(
                              icon: AppIcon.chatBot,
                              label: t.label.menu.molasapp,
                              bgColor: extensionColor?.successContainer,
                              textColor: extensionColor?.onSuccessContainer,
                              onTap: () async {
                                if (!await launchUrl(
                                  Uri.parse(
                                    'https://wa.me/6285232448912?text=Halo',
                                  ),
                                  mode: LaunchMode.externalApplication,
                                )) {
                                  showGetSnackBar(
                                    title: 'Kesalahan!',
                                    message: 'Gagal menjalankan Molasapp!',
                                    variant: AlertVariant.error,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: kPadding16H,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        t.label.video(count: 1),
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onBackground,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      AppButton(
                        size: ButtonSize.small,
                        variant: ButtonVariant.flat,
                        label: t.label.btn.see_more,
                        onPressed: () {
                          showBottomSheetDialog(
                            context: context,
                            content: const ComingSoon(),
                          );
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: kPadding16,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: YoutubePlayer(
                      showVideoProgressIndicator: true,
                      controller: controller.youtubePlayerController,
                      bottomActions: [
                        CurrentPosition(),
                        ProgressBar(
                          isExpanded: true,
                        ),
                        RemainingDuration(),
                      ],
                    ),
                  ),
                ),
                verticalSpace(16),
                Padding(
                  padding: kPadding16H,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Grafik',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onBackground,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      AppButton(
                        size: ButtonSize.small,
                        variant: ButtonVariant.flat,
                        label: t.label.btn.see_more,
                        onPressed: () {
                          showBottomSheetDialog(
                            context: context,
                            content: const ComingSoon(),
                          );
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  margin: kPadding16,
                  padding: kPadding16,
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: theme.shadowColor.withOpacity(0.1),
                        blurRadius: 20,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: Get.height * 0.25,
                          maxWidth: Get.width,
                        ),
                        child: Obx(
                          () {
                            final data = controller.totalPopulation.value;
                            final xLabel = data?.derivedDataPeriods.first.label;
                            final yLabel = data?.variables.first?.unit;
                            final location = data?.verticalVariables.first;
                            final level = location?.val == 7315
                                ? 'Kabupaten'
                                : data?.verticalVariableLabel;
                            final title =
                                '${data?.variables.first?.label} $level ${location?.label}';
                            return LineChart(
                              LineChartData(
                                gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: true,
                                  horizontalInterval: 2,
                                  verticalInterval: 1,
                                  getDrawingHorizontalLine: (value) {
                                    return FlLine(
                                      color: theme.dividerColor,
                                      strokeWidth: 0.8,
                                    );
                                  },
                                  getDrawingVerticalLine: (value) {
                                    return FlLine(
                                      color: theme.dividerColor,
                                      strokeWidth: 0.7,
                                    );
                                  },
                                ),
                                titlesData: FlTitlesData(
                                  show: true,
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  topTitles: AxisTitles(
                                      axisNameWidget: FittedBox(
                                        child: Text(
                                          title,
                                          style: theme.textTheme.labelLarge
                                              ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (_, __) =>
                                            const SizedBox.shrink(),
                                      )),
                                  bottomTitles: AxisTitles(
                                    axisNameWidget: Text(
                                      xLabel.toString(),
                                      style: theme.textTheme.labelLarge,
                                    ),
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 30,
                                      interval: 1,
                                      getTitlesWidget: (value, meta) {
                                        return SideTitleWidget(
                                          axisSide: meta.axisSide,
                                          child: Text(
                                            value.toStringAsFixed(0),
                                            style: theme.textTheme.caption
                                                ?.copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    axisNameWidget: Text(
                                      yLabel.toString(),
                                      style: theme.textTheme.labelLarge,
                                    ),
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: 2,
                                      getTitlesWidget: (value, meta) {
                                        return SideTitleWidget(
                                          axisSide: meta.axisSide,
                                          space: 8.0,
                                          child: Text(meta.formattedValue),
                                        );
                                      },
                                      reservedSize: 42,
                                    ),
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border(
                                    left: BorderSide(
                                      color: theme.dividerColor,
                                      width: 1,
                                    ),
                                    bottom: BorderSide(
                                      color: theme.dividerColor,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                lineTouchData: LineTouchData(
                                  touchTooltipData: LineTouchTooltipData(
                                    tooltipBgColor: theme.canvasColor,
                                    tooltipRoundedRadius: 12,
                                    getTooltipItems: (spots) {
                                      final textStyle =
                                          theme.textTheme.labelLarge?.copyWith(
                                                color:
                                                    theme.colorScheme.primary,
                                                fontWeight: FontWeight.w400,
                                              ) ??
                                              theme.textTheme.bodyMedium!;
                                      return [
                                        LineTooltipItem(
                                            '$xLabel ${spots.first.x.toStringAsFixed(0)}:\n',
                                            textStyle,
                                            textAlign: TextAlign.start,
                                            children: [
                                              TextSpan(
                                                text: spots.first.y
                                                    .toStringAsFixed(0),
                                                style: textStyle.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' $yLabel',
                                              )
                                            ]),
                                      ];
                                    },
                                  ),
                                ),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots:
                                        controller.totalPopulationsData.value,
                                    preventCurveOverShooting: true,
                                    isCurved: true,
                                    gradient: LinearGradient(
                                      colors: [
                                        theme.primaryColor,
                                        theme.primaryColorLight,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    barWidth: 5,
                                    isStrokeCapRound: true,
                                    shadow: Shadow(
                                      color: theme.colorScheme.primary
                                          .withOpacity(0.5),
                                      blurRadius: 10,
                                    ),
                                    dotData: FlDotData(
                                      show: false,
                                    ),
                                    belowBarData: BarAreaData(
                                      show: true,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(16),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPageIndicatorSection() {
    if (controller.isBannerLoading.value) {
      return ShimmerWidget(
        width: Get.width * 0.1,
        height: 10,
      );
    }

    if (controller.isBannerError.value) {
      return verticalSpace(10);
    }

    return AnimatedSmoothIndicator(
      activeIndex: controller.activeCarousel.value,
      count: controller.banners.value.length,
      effect: const ScrollingDotsEffect(
        dotColor: kColorNeutral40,
        dotHeight: 10,
        dotWidth: 10,
        activeDotColor: kColorPrimary,
        activeDotScale: 1,
      ),
      onDotClicked: (page) {
        controller.activeCarousel.value = page;
        controller.carouselController.animateToPage(page);
      },
    );
  }

  Widget _buildBannerSection(ThemeData theme) {
    if (controller.isBannerLoading.value || controller.banners.value.isEmpty) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: Get.height * 0.18,
          minHeight: Get.height * 0.18,
          maxWidth: Get.width,
        ),
        child: CarouselSlider.builder(
          itemCount: 10,
          itemBuilder: (context, index, actualIndex) => ShimmerWidget(
            width: Get.width,
            height: Get.height * 0.18,
          ),
          options: CarouselOptions(
            height: Get.height * 0.2,
            enlargeCenterPage: true,
            pageSnapping: true,
            enableInfiniteScroll: true,
            viewportFraction: 0.8,
            autoPlay: false,
            initialPage: 0,
          ),
        ),
      );
    }

    if (controller.isBannerError.value) {
      return SizedBox(
        width: Get.width,
        height: Get.height * 0.18,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Gagal memuat data banner!',
              semanticsLabel:
                  'Gagal memuat data banner. Tekan tombol dibawah untuk memuat kembali.',
            ),
            verticalSpace(8),
            AppButton(
              size: ButtonSize.small,
              icon: Icons.refresh,
              label: 'Muat Ulang',
              onPressed: controller.loadBanners,
              variant: ButtonVariant.flat,
            )
          ],
        ),
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: Get.height * 0.18,
        minHeight: Get.height * 0.18,
        maxWidth: Get.width,
      ),
      child: Obx(
        () => CarouselSlider.builder(
          carouselController: controller.carouselController,
          itemCount: controller.banners.value.length,
          itemBuilder: (context, index, actualIndex) {
            final banner = controller.banners[index];
            final storage = Supabase.instance.client.storage
                .from(FlutterConfig.get(kEnvKeySupabaseBucketName));
            final imageUrl = storage.getPublicUrl(banner.image).data;
            return InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () async {
                await FirebaseAnalytics.instance.logSelectContent(
                  contentType: kTableBanners,
                  itemId: banner.id.toString(),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ExtendedImage.network(
                  imageUrl ?? '',
                  width: Get.width,
                  border: Border.all(color: theme.dividerColor),
                  fit: BoxFit.fill,
                  semanticLabel:
                      '${banner.title}. ${Bidi.stripHtmlIfNeeded(banner.description)}',
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          },
          options: CarouselOptions(
            onPageChanged: controller.onPageChanged,
            onScrolled: controller.onPageScrolled,
            height: Get.height * 0.2,
            enlargeCenterPage: true,
            pageSnapping: true,
            enableInfiniteScroll: true,
            viewportFraction: 0.8,
            autoPlay: true,
            initialPage: 0,
          ),
        ),
      ),
    );
  }
}
