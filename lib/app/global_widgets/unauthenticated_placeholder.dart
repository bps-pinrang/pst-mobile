import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pst_online/app/global_widgets/lottie_with_author.dart';

import '../core/enums/app_animation.dart';
import '../core/enums/button_size.dart';
import '../core/enums/button_variant.dart';
import '../core/utils/view_helper.dart';
import '../routes/app_pages.dart';
import 'app_button.dart';
import '../../i18n/strings.g.dart';

class UnauthenticatedPlaceholder extends StatelessWidget {
  const UnauthenticatedPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LottieWithAuthor(
            title: 'Oooppss',
            message: t.unauthenticated.label,
            animation: AppAnimation.login,
            height: Get.height * 0.3,
            semanticLabel: t.unauthenticated.semantics,
          ),
          verticalSpace(8),
          AppButton(
            size: ButtonSize.large,
            label: t.label.btn.login,
            variant: ButtonVariant.primary,
            onPressed: () {
              Navigator.of(context).pop();
              Get.offAllNamed(Routes.login);
            },
          )
        ],
      ),
    );
  }
}
