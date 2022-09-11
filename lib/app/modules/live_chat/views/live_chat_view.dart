import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pst_online/app/core/enums/app_animation.dart';
import 'package:pst_online/app/core/utils/view_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/live_chat_controller.dart';
import '../../../../i18n/strings.g.dart';

class LiveChatView extends GetView<LiveChatController> {
  const LiveChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.label.menu.live_chat.replaceFirst('\n', ' ')),
          actions: [
            IconButton(
              onPressed: Get.back,
              icon: const Icon(Icons.close),
            )
          ],
        ),
        body: Obx(
          () => Tawk(
            directChatLink: controller.liveChatUrl.value,
            visitor: TawkVisitor(
              name: controller.name.value,
              email: controller.email.value,
            ),
            onLinkTap: (url) => launchUrl(
              Uri.parse(url),
              mode: LaunchMode.externalApplication,
            ),
            placeholder: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    AppAnimation.loader.value,
                    width: 80,
                    height: 80,
                  ),
                  verticalSpace(8),
                  const Text('Sedang memuat live chat!')
                ],
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
