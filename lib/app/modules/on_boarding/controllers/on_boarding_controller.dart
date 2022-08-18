import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:pst_online/app/core/enums/app_animation.dart';
import 'package:pst_online/app/core/values/color.dart';

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

  final content = <Map<String,String>>[
    {
      'title': 'Publikasi',
      'message':
          'Akses berbagai publikasi, rilis, data, dan berbagai insight menarik dari BPS Kabupaten Pinrang',
    },
    {
      'title': 'Statistik',
      'message':
          'Akses data-data statistik, analisis, dan indikator strategis Kabupaten Pinrang',
    },
    {
      'title': '24/7',
      'message':
          'Akses kapan saja, dimana saja, PST Mobile siap melayani anda 7 x 24 jam.',
    },
  ].obs;

  final activeImagePage = 0.obs;
  final activeMessagePage = 0.obs;
  final CarouselController imageController = CarouselController();
  final CarouselController messageController = CarouselController();
}
