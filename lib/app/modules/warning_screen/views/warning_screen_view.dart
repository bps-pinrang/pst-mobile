import 'package:animate_do/animate_do.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pst_online/app/core/enums/app_logo.dart';
import 'package:pst_online/app/core/values/color.dart';
import 'package:pst_online/app/core/values/size.dart';
import 'package:pst_online/app/global_widgets/lottie_logo.dart';

import '../../../core/utils/view_helper.dart';
import '../controllers/warning_screen_controller.dart';
import '../../../../i18n/strings.g.dart';

class WarningScreenView extends GetView<WarningScreenController> {
  const WarningScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: kColorNeutral10,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: kColorNeutral10,
        body: SingleChildScrollView(
          padding: kPadding16,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: Get.height),
            child: Stack(
              fit: StackFit.loose,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Lottie.asset(
                        controller.animation.value,
                        width: Get.width * 0.6,
                      ),
                      verticalSpace(8),
                      Focus(
                        autofocus: true,
                        includeSemantics: true,
                        child: Text(
                          controller.message,
                          semanticsLabel: controller.semantics,
                        ),
                      ),
                      verticalSpace(24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: LottieLogo(
                              author: controller.animation.author,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 32,
                  left: 0,
                  right: 0,
                  child: FadeInUp(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ExtendedImage.asset(
                          AppLogo.bpsRb.value,
                          height: 40,
                          semanticLabel: t.semantics.rbBpsLogo,
                        ),
                        ExtendedImage.asset(
                          AppLogo.bpsH.value,
                          height: 40,
                          semanticLabel: t.semantics.bpsLogo,
                        ),
                        ExtendedImage.asset(
                          AppLogo.pstH.value,
                          height: 40,
                          semanticLabel: t.semantics.pstLogo,
                        ),
                        ExtendedImage.asset(
                          AppLogo.pia.value,
                          height: 40,
                          semanticLabel: t.semantics.bpsCoreValueLogo,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
