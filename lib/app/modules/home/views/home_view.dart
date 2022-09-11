// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:upgrader/upgrader.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return UpgradeAlert(
      upgrader: Upgrader(
        canDismissDialog: true,
        debugDisplayAlways: true,
        debugLogging: true,
        durationUntilAlertAgain: 1.minutes,
        shouldPopScope: () => true,
      ),
      child: PersistentTabView(
        context,
        screens: controller.pages,
        padding: const NavBarPadding.all(8),
        controller: controller.persistentTabController,
        items: [
          PersistentBottomNavBarItem(
            icon: const Icon(
              Icons.home,
            ),
            inactiveIcon: const Icon(
              Icons.home_outlined,
            ),
            title: 'Beranda',
            textStyle: textTheme.labelMedium,
            iconSize: 24,
            activeColorPrimary: theme.colorScheme.primary,
            activeColorSecondary: theme.colorScheme.primary,
            inactiveColorPrimary: theme.colorScheme.primary,
            inactiveColorSecondary: theme.colorScheme.primary,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(
              CupertinoIcons.bell_fill,
            ),
            inactiveIcon: const Icon(
              CupertinoIcons.bell,
            ),
            title: 'Pemberitahuan',
            textStyle: textTheme.labelMedium,
            iconSize: 24,
            activeColorPrimary: theme.colorScheme.primary,
            activeColorSecondary: theme.colorScheme.primary,
            inactiveColorPrimary: theme.colorScheme.primary,
            inactiveColorSecondary: theme.colorScheme.primary,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(
              Icons.history_rounded,
            ),
            inactiveIcon: const Icon(
              LineIcons.history,
            ),
            title: 'Riwayat',
            textStyle: textTheme.labelMedium,
            iconSize: 24,
            activeColorPrimary: theme.colorScheme.primary,
            activeColorSecondary: theme.colorScheme.primary,
            inactiveColorPrimary: theme.colorScheme.primary,
            inactiveColorSecondary: theme.colorScheme.primary,
          ),
          PersistentBottomNavBarItem(
            icon: Icon(
              CupertinoIcons.profile_circled,
              color: theme.colorScheme.primary,
            ),
            inactiveIcon: const Icon(
              CupertinoIcons.profile_circled,
            ),
            title: 'Profil',
            textStyle: textTheme.labelMedium,
            iconSize: 24,
            activeColorPrimary: theme.colorScheme.primary,
            activeColorSecondary: theme.colorScheme.primary,
            inactiveColorPrimary: theme.colorScheme.primary,
            inactiveColorSecondary: theme.colorScheme.primary,
          )
        ],
        popActionScreens: PopActionScreensType.all,
        popAllScreensOnTapOfSelectedTab: true,
        navBarStyle: NavBarStyle.style1,
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          duration: 200.milliseconds,
        ),
        confineInSafeArea: true,
        hideNavigationBarWhenKeyboardShows: true,
        resizeToAvoidBottomInset: true,
        bottomScreenMargin: 48,
        decoration: NavBarDecoration(boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 6,
            blurStyle: BlurStyle.normal,
          )
        ]),
        backgroundColor: theme.bottomAppBarColor,
      ),
    );
  }
}
