// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pst_online/app/core/extensions/custom_color.dart';
import 'package:pst_online/app/global_widgets/coming_soon.dart';

import '../../../core/values/size.dart';
import '../../../global_widgets/unauthenticated_placeholder.dart';
import '../controllers/home_controller.dart';

class NotificationView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    final theme = Theme.of(context);
    final extensionColor = Theme.of(context).extension<CustomColors>();

    if (controller.user.value == null) {
      return Container(
        padding: kPadding16,
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [UnauthenticatedPlaceholder()],
        ),
      );
    }

    return const Center(
      child: Padding(
        padding: kPadding16,
        child: ComingSoon(),
      ),
    );
  }
}
