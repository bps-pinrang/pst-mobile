// ignore_for_file: invalid_use_of_protected_member

import 'package:animate_do/animate_do.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pst_online/app/core/utils/view_helper.dart';
import 'package:pst_online/app/core/values/size.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:pst_online/app/global_widgets/alert_variant.dart';
import 'package:pst_online/app/global_widgets/unauthenticated_placeholder.dart';
import 'package:pst_online/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/enums/app_logo.dart';
import '../../../global_widgets/coming_soon.dart';
import '../controllers/home_controller.dart';
import '../../../../i18n/strings.g.dart';

class ProfileView extends GetView<HomeController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    if (controller.user.value == null) {
      return Scaffold(
        body: Container(
          padding: kPadding16,
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [UnauthenticatedPlaceholder()],
          ),
        ),
      );
    }

    final user = controller.user.value!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        surfaceTintColor: theme.canvasColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: kPadding16,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 24,
                    child: Text(user.name[0]),
                  ),
                  horizontalSpace(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(
                            user.name,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        verticalSpace(8),
                        Text(
                          user.email,
                          style: textTheme.caption,
                        ),
                        verticalSpace(4),
                        Text(
                          user.phone,
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              height: 2,
            ),
            Padding(
              padding: kPadding16H8V,
              child: Text(
                'Akun',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Divider(
              height: 2,
            ),
            ListView.separated(
              itemBuilder: (_, index) {
                final menuItem = _accountMenuList[index];
                return ListTile(
                  title: Text(
                    menuItem[kJsonKeyTitle],
                    style: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: menuItem['on_tap'],
                  leading: Icon(menuItem['icon']),
                  trailing: const Icon(Icons.chevron_right),
                );
              },
              separatorBuilder: (_, __) =>
              const Divider(
                height: 2,
              ),
              itemCount: _accountMenuList.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            ),
            const Divider(
              height: 2,
            ),
            Padding(
              padding: kPadding16H8V,
              child: Text(
                'Pekerjaan',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Divider(
              height: 2,
            ),
            ListView.separated(
              itemBuilder: (_, index) {
                final menuItem = _workMenuList[index];
                return ListTile(
                  title: Text(
                    menuItem[kJsonKeyTitle],
                    style: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: menuItem['on_tap'],
                  leading: Icon(menuItem['icon']),
                  trailing: const Icon(Icons.chevron_right),
                );
              },
              separatorBuilder: (_, __) =>
              const Divider(
                height: 2,
              ),
              itemCount: _workMenuList.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            ),
            const Divider(
              height: 2,
            ),
            Padding(
              padding: kPadding16H8V,
              child: Text(
                'Aplikasi',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Divider(
              height: 2,
            ),
            ListView.separated(
              itemBuilder: (_, index) {
                final menuItem = _appMenuList[index];
                return ListTile(
                  title: Text(
                    menuItem[kJsonKeyTitle],
                    style: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: menuItem['on_tap'],
                  leading: Icon(menuItem['icon']),
                  trailing: const Icon(Icons.chevron_right),
                );
              },
              separatorBuilder: (_, __) =>
              const Divider(
                height: 2,
              ),
              itemCount: _appMenuList.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            ),
            const Divider(
              height: 2,
            ),
            verticalSpace(16),
            Center(
              child: Obx(
                    () =>
                    Column(
                      children: [
                        ExtendedImage.asset(
                          AppLogo.pstV.value,
                          height: 60,
                          semanticLabel: t.semantics.pstLogo,
                        ),
                        verticalSpace(8),
                        Text(
                          controller.appName.value,
                          style: textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        verticalSpace(4),
                        Text(
                          controller.appVersion.value,
                          style: textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
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
                                  AppLogo.berakhlak.value,
                                  height: 40,
                                ),
                              ),
                            ),
                            Expanded(
                              child: FadeInUp(
                                duration: 1.seconds,
                                child: ExtendedImage.asset(
                                  AppLogo.bpsH.value,
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
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> get _accountMenuList {
    return [
      {
        kJsonKeyTitle: 'Update Profil',
        kJsonKeyDescription: '',
        'on_tap': () {
          showBottomSheetDialog(
            content: const ComingSoon(),
          );
        },
        'icon': LineIcons.user,
      },
      {
        kJsonKeyTitle: 'Ganti Password',
        kJsonKeyDescription: '',
        'on_tap': () {
          showBottomSheetDialog(
            content: const ComingSoon(),
          );
        },
        'icon': LineIcons.lock,
      },
      {
        kJsonKeyTitle: 'Keluar',
        kJsonKeyDescription: '',
        'on_tap': controller.handleLogout,
        'icon': LineIcons.alternateSignOut,
      }
    ];
  }

  List<Map<String, dynamic>> get _workMenuList {
    return [
      {
        kJsonKeyTitle: 'Riwayat Pekerjaan',
        kJsonKeyDescription: '',
        'on_tap': () {
          showBottomSheetDialog(
            content: const ComingSoon(),
          );
        },
        'icon': LineIcons.building,
      },
    ];
  }

  List<Map<String, dynamic>> get _appMenuList {
    return [
      {
        kJsonKeyTitle: 'Tentang Kami',
        kJsonKeyDescription: '',
        'on_tap': () {
          showBottomSheetDialog(
            content: const ComingSoon(),
          );
        },
        'icon': LineIcons.info,
      },
      {
        kJsonKeyTitle: 'Beri Rating',
        kJsonKeyDescription: '',
        'on_tap': () async {
          if (!(await launchUrl(
            Uri.parse(
                'https://play.google.com/store/apps/details?id=id.go.bps.pinrangkab.pst_mobile'),
            mode: LaunchMode.externalApplication,
          ))) {
            showGetSnackBar(
              title: 'Gagal!',
              message: 'Tidak bisa membuka aplikasi!',
              variant: AlertVariant.error,
            );
          }
        },
        'icon': LineIcons.star,
      },
      {
        kJsonKeyTitle: 'Riwayat Unduh',
        kJsonKeyDescription: '',
        'on_tap': () {
          Get.toNamed(Routes.downloadHistory);
        },
        'icon': LineIcons.download,
      },
    ];
  }
}
