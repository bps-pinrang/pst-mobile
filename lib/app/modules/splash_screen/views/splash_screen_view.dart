import 'package:animate_do/animate_do.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pst_online/app/core/enums/app_animation.dart';
import 'package:pst_online/app/core/enums/app_logo.dart';
import 'package:pst_online/app/core/utils/view_helper.dart';
import 'package:pst_online/app/core/values/color.dart';
import 'package:pst_online/app/core/values/size.dart';
import 'package:pst_online/app/core/values/style.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: kColorNeutral10,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: kColorNeutral10,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: kColorNeutral10,
        body: Padding(
          padding: kPadding8,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FadeInRight(
                        duration: 1.seconds,
                        child: ExtendedImage.asset(
                          AppLogo.pstV.value,
                          clearMemoryCacheWhenDispose: true,
                          enableMemoryCache: true,
                          height: 80,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                      child: VerticalDivider(
                        color: kColorNeutral80,
                      ),
                    ),
                    Expanded(
                      child: FadeInLeft(
                        duration: 1.seconds,
                        child: ExtendedImage.asset(
                          AppLogo.bpsV.value,
                          clearMemoryCacheWhenDispose: true,
                          enableMemoryCache: true,
                          height: 80,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Lottie.asset(
                      AppAnimation.loader2.value,
                      fit: BoxFit.cover,
                      width: 200,
                      height: 120,
                    ),
                    Obx(
                      () => Text(
                        'PST Mobile ${controller.appVersion.value}',
                        style: kTextStyleBody2.copyWith(
                          color: kColorPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    verticalSpace(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: FadeInLeft(
                            duration: 1.seconds,
                            child: ExtendedImage.asset(
                              AppLogo.bpsRb.value,
                              height: 40,
                            ),
                          ),
                        ),
                        Expanded(
                          child: FadeInUp(
                            duration: 1.seconds,
                            child: ExtendedImage.asset(
                              AppLogo.pia.value,
                              height: 40,
                            ),
                          ),
                        ),
                        Expanded(
                          child: FadeInUp(
                            duration: 1.seconds,
                            child: ExtendedImage.asset(
                              AppLogo.berakhlak.value,
                              height: 70,
                            ),
                          ),
                        ),
                        Expanded(
                          child: FadeInRight(
                            duration: 1.seconds,
                            child: ExtendedImage.asset(
                              AppLogo.berakhlakAlt.value,
                              height: 30,
                            ),
                          ),
                        )
                      ],
                    ),
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
