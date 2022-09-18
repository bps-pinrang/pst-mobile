import 'package:get/get.dart';

import '../modules/download_history/bindings/download_history_binding.dart';
import '../modules/download_history/views/download_history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/live_chat/bindings/live_chat_binding.dart';
import '../modules/live_chat/views/live_chat_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/news/bindings/news_binding.dart';
import '../modules/news/views/news_view.dart';
import '../modules/news_detail/bindings/news_detail_binding.dart';
import '../modules/news_detail/views/news_detail_view.dart';
import '../modules/on_boarding/bindings/on_boarding_binding.dart';
import '../modules/on_boarding/views/on_boarding_view.dart';
import '../modules/pdf_reader/bindings/pdf_reader_binding.dart';
import '../modules/pdf_reader/views/pdf_reader_view.dart';
import '../modules/publication_detail/bindings/publication_detail_binding.dart';
import '../modules/publication_detail/views/publication_detail_view.dart';
import '../modules/publications/bindings/publications_binding.dart';
import '../modules/publications/views/publications_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/warning_screen/bindings/warning_screen_binding.dart';
import '../modules/warning_screen/views/warning_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splashScreen;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.splashScreen,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.onBoarding,
      page: () => const OnBoardingView(),
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: _Paths.warningScreen,
      page: () => const WarningScreenView(),
      binding: WarningScreenBinding(),
    ),
    GetPage(
      name: _Paths.liveChat,
      page: () => const LiveChatView(),
      binding: LiveChatBinding(),
    ),
    GetPage(
      name: _Paths.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.downloadHistory,
      page: () => const DownloadHistoryView(),
      binding: DownloadHistoryBinding(),
    ),
    GetPage(
      name: _Paths.publications,
      page: () => const PublicationsView(),
      binding: PublicationsBinding(),
    ),
    GetPage(
      name: _Paths.publicationDetail,
      page: () => const PublicationDetailView(),
      binding: PublicationDetailBinding(),
    ),
    GetPage(
      name: _Paths.pdfReader,
      page: () => const PdfReaderView(),
      binding: PdfReaderBinding(),
    ),
    GetPage(
      name: _Paths.news,
      page: () => const NewsView(),
      binding: NewsBinding(),
    ),
    GetPage(
      name: _Paths.newsDetail,
      page: () => const NewsDetailView(),
      binding: NewsDetailBinding(),
    ),
  ];
}
