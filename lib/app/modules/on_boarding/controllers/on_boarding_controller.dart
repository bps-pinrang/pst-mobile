import 'package:carousel_slider/carousel_controller.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';
import 'package:pst_online/app/core/enums/app_animation.dart';
import 'package:pst_online/app/core/values/color.dart';
import 'package:pst_online/app/core/values/strings.dart';
import '../../../../i18n/strings.g.dart';

class OnBoardingController extends GetxController {
  final items = [
    AppAnimation.bookIdea,
    AppAnimation.statistics,
    AppAnimation.available24H,
  ];

  final colors = [
    kColorPrimaryBorder,
    kColorWarningBorder,
    kColorSuccessBorder,
  ].obs;

  final indicatorColors = [
    kColorPrimary,
    kColorWarning,
    kColorSuccess,
  ].obs;

  final content = <Map<String, String>>[
    {
      kDataKeyTitle: t.onBoarding.title.publication,
      kDataKeyMessage: t.onBoarding.caption.publication,
    },
    {
      kDataKeyTitle: t.onBoarding.title.statistics,
      kDataKeyMessage: t.onBoarding.caption.statistics,
    },
    {
      kDataKeyTitle: t.onBoarding.title.activeHour,
      kDataKeyMessage: t.onBoarding.caption.activeHour,
    },
  ].obs;

  final activeImagePage = 0.obs;
  final activeMessagePage = 0.obs;
  final CarouselController imageController = CarouselController();
  final CarouselController messageController = CarouselController();

  double get headerPosition {
    return 24;
  }

  @override
  void onInit() async {
    await FirebaseAnalytics.instance.setCurrentScreen(
      screenName: 'OnBoarding',
    );
    super.onInit();
  }
}
