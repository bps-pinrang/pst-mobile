
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:pst_online/app/data/models/banner_model.dart';
import 'package:pst_online/app/data/models/dynamic_table/data_response.dart';
import 'package:pst_online/app/data/providers/youtube_provider.dart';
import 'package:pst_online/app/modules/home/screens/booking_history_view.dart';
import 'package:pst_online/app/modules/home/screens/main_view.dart';
import 'package:pst_online/app/modules/home/screens/notification_view.dart';
import 'package:pst_online/app/modules/home/screens/profile_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '/app/data/providers/api_provider.dart';

class HomeController extends GetxController {
  late ApiProvider provider;
  late YoutubeProvider youtubeProvider;
  final GetStorage box = GetStorage();

  final ScrollController scrollController = ScrollController();
  final CarouselController carouselController = CarouselController();
  final PersistentTabController persistentTabController =
      PersistentTabController(
    initialIndex: 0,
  );

  final client = Supabase.instance.client;
  Rx<User?> user = Rx(null);
  Rxn<DataResponse> totalPopulation = Rxn(null);
  YoutubePlayerController youtubePlayerController = YoutubePlayerController(
    initialVideoId: 'z-7yCWZ6B-U',
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      controlsVisibleAtStart: false,
      hideControls: false,
      hideThumbnail: false,
      loop: false,
      showLiveFullscreenButton: false,
      useHybridComposition: false,
      mute: false,
    ),
  );

  final activeCarousel = 0.obs;

  final banners = List<BannerModel>.empty(growable: true).obs;
  final totalPopulationsData = List<FlSpot>.empty(growable: true).obs;
  final pages = <Widget>[
    const MainView(),
    NotificationView(),
    const BookingHistoryView(),
    const ProfileView(),
  ];

  final isLoggedIn = false.obs;
  final isBannerError = false.obs;
  final isBannerLoading = false.obs;

  @override
  void onInit() async {
    provider = GetInstance().find<ApiProvider>();
    super.onInit();
    _authentication();
    loadBanners();
    loadTotalPopulations();
  }

  void _authentication() async {
    final session = box.read(kStorageKeySession);

    if (session != null) {
      final response = await client.auth.recoverSession(session);
      if (response.error != null) {
        box.write(kStorageKeySession, response.data?.persistSessionString);
      }
    }

    user.value = client.auth.user();
  }

  dynamic onPageChanged(int page, reason) {
    activeCarousel.value = page;
  }

  void onPageScrolled(double? page) {
    if (page == null) return;
    if (page > banners.length) return;
    activeCarousel.value = page.round();
  }

  Future<void> loadBanners() async {
    try {
      isBannerError.value = false;
      isBannerLoading.value = true;
      final result = await client
          .from(kTableBanners)
          .select()
          .match({
            'is_showing': true,
          })
          .limit(10)
          .order('created_at')
          .execute();

      banners.value =
          (result.data as List).map((e) => BannerModel.fromJson(e)).toList();
    } catch (e) {
      print(e.toString());
      isBannerError.value = true;
    } finally {
      isBannerLoading.value = false;
    }
  }

  Future<void> loadTotalPopulations() async {
    try {
      final result = await provider.loadData(
        variable: '34',
        verticalVariable: '7315',
      );

      result.fold(
        (failure) {
          //
        },
        (response) {
          totalPopulation.value = response;
          final data = response.data.values.toList();
          final periods = response.dataPeriods;
          var dataPopulations = List<FlSpot>.empty(growable: true);

          for (var i = 0; i < data.length; i++) {
            final value = int.parse(periods[i].label);
            if(value >= 2010 && value <= 2022) {
              dataPopulations.add(
                FlSpot(
                  value.toDouble(),
                  double.parse(data[i].toString()),
                ),
              );
            }
          }

          totalPopulationsData.value = dataPopulations;
        },
      );
    } catch (e) {
      //
    }
  }


  @override
  void onClose() {
    scrollController.dispose();
    youtubePlayerController.dispose();
    persistentTabController.dispose();
    super.onClose();
  }
}
