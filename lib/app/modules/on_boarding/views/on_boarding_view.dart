import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pst_online/app/core/enums/app_logo.dart';
import 'package:pst_online/app/core/values/color.dart';
import 'package:pst_online/app/core/values/size.dart';
import 'package:pst_online/app/core/values/style.dart';
import 'package:pst_online/app/routes/app_pages.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controllers/on_boarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: kColorNeutral10,
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        body: Obx(
          () => AnimatedContainer(
            duration: 500.milliseconds,
            height: Get.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  controller.colors[controller.activeImagePage.value]
                      .withOpacity(0.2),
                  controller.indicatorColors[controller.activeImagePage.value],
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: Get.statusBarHeight - 40,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Padding(
                        padding: kPadding16H8V,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    'Powered by ',
                                    style: kTextStyleCaption,
                                  ),
                                  SvgPicture.asset(
                                    AppLogo.lottieFiles.value,
                                    width: Get.width * 0.15,
                                  ),
                                ],
                              ),
                            ),
                            Obx(
                              () => AnimatedOpacity(
                                opacity: controller.activeImagePage.value > 0
                                    ? 1
                                    : 0,
                                duration: 500.milliseconds,
                                child: TextButton(
                                  onPressed:
                                      controller.activeImagePage.value > 0
                                          ? () => Get.offAllNamed(Routes.home)
                                          : null,
                                  child: Obx(
                                    () => Text(
                                      'Lewati',
                                      style: kTextStyleBody1.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: controller.indicatorColors[
                                              controller
                                                  .activeImagePage.value]),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      CarouselSlider(
                        items: controller.items
                            .map(
                              (animation) => Column(
                                children: [
                                  Lottie.asset(
                                    animation.value,
                                    height: Get.height * 0.2,
                                    fit: BoxFit.cover,
                                  ),
                                  kSizedBoxH14,
                                  Container(
                                    width: double.infinity,
                                    padding: kPadding16H8V,
                                    child: RichText(
                                      textAlign: TextAlign.end,
                                      text: TextSpan(
                                        text: 'Animation by ',
                                        style: kTextStyleCaption.copyWith(
                                          fontSize: 10,
                                          color: kColorNeutral70,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: animation.author,
                                            style: kTextStyleCaption.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: kColorNeutral80,
                                              fontSize: 10,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                        carouselController: controller.imageController,
                        options: CarouselOptions(
                          autoPlay: false,
                          viewportFraction: 1,
                          height: Get.height * 0.26,
                          onPageChanged: (page, reason) {
                            controller.messageController.animateToPage(page);
                          },
                          initialPage: 0,
                          aspectRatio: 0.75,
                          enableInfiniteScroll: false,
                          onScrolled: (page) {
                            controller.activeImagePage.value = page!.round();
                          },
                          pageSnapping: false,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: Get.height * 0.65,
                    width: double.infinity,
                    padding: kPadding16,
                    decoration: const BoxDecoration(
                      color: kColorNeutral10,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(220),
                      ),
                    ),
                    child: Column(
                      children: [
                        Obx(
                          () => AnimatedSmoothIndicator(
                            activeIndex: controller.activeImagePage.value,
                            count: controller.items.length,
                            effect: ExpandingDotsEffect(
                              dotWidth: 8,
                              dotHeight: 8,
                              activeDotColor: controller.indicatorColors[
                                  controller.activeImagePage.value],
                              dotColor: kColorNeutral50,
                            ),
                          ),
                        ),
                        kSizedBoxH48,
                        CarouselSlider(
                          carouselController: controller.messageController,
                          items: controller.content
                              .map(
                                (element) => Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 24),
                                      child: Text(
                                        element['title']!.toUpperCase(),
                                        style: kTextStyleTitle1.copyWith(
                                          fontSize: 72,
                                        ),
                                      ),
                                    ),
                                    kSizedBoxH14,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                      ),
                                      child: Text(
                                        element['message']!,
                                        style: kTextStyleTitle5.copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                            autoPlay: false,
                            viewportFraction: 1,
                            height: Get.height * 0.48,
                            onPageChanged: (page, reason) {
                              controller.imageController.animateToPage(page);
                            },
                            initialPage: 0,
                            aspectRatio: 0.75,
                            enableInfiniteScroll: false,
                            onScrolled: (page) {
                              controller.activeMessagePage.value =
                                  page!.round();
                            },
                            pageSnapping: false,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ExtendedImage.asset(
                                AppLogo.pstH.value,
                                height: 50,
                              ),
                            ),
                            Expanded(
                              child: ExtendedImage.asset(
                                AppLogo.berakhlakAlt.value,
                                height: 30,
                              ),
                            ),
                            kSizedBoxW14,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Obx(
                                  () => AnimatedContainer(
                                    duration: 500.milliseconds,
                                    decoration: BoxDecoration(
                                      color:
                                          controller.activeImagePage.value == 0
                                              ? kColorNeutral50
                                              : kColorErrorPressed,
                                      boxShadow:
                                          controller.activeImagePage.value == 0
                                              ? null
                                              : [
                                                  BoxShadow(
                                                    color: kColorErrorPressed
                                                        .withOpacity(0.4),
                                                    spreadRadius: 4,
                                                    blurRadius: 10,
                                                  )
                                                ],
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(100),
                                      elevation: 0,
                                      child: InkWell(
                                        onTap: () {
                                          controller.imageController
                                              .previousPage();
                                          controller.messageController
                                              .previousPage();
                                        },
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: const Padding(
                                          padding: kPadding16,
                                          child: Icon(
                                            Icons.chevron_left,
                                            color: kColorNeutral10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                kSizedBoxW8,
                                Obx(
                                  () => AnimatedContainer(
                                    duration: 500.milliseconds,
                                    decoration: BoxDecoration(
                                      color: controller.indicatorColors[
                                          controller.activeImagePage.value],
                                      boxShadow: [
                                        BoxShadow(
                                          color: controller.indicatorColors[
                                                  controller
                                                      .activeImagePage.value]
                                              .withOpacity(0.4),
                                          spreadRadius: 4,
                                          blurRadius: 10,
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(100),
                                      elevation: 0,
                                      child: InkWell(
                                        onTap: controller
                                                    .activeImagePage.value ==
                                                2
                                            ? () => Get.offAllNamed(Routes.home)
                                            : () {
                                                controller.imageController
                                                    .nextPage();
                                                controller.messageController
                                                    .nextPage();
                                              },
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Padding(
                                          padding: kPadding16,
                                          child: Icon(
                                            controller.activeImagePage.value ==
                                                    2
                                                ? Icons.check
                                                : Icons.chevron_right,
                                            color: kColorNeutral10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
