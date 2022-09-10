import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../core/enums/app_animation.dart';
import '../core/enums/button_size.dart';
import '../core/enums/button_variant.dart';
import '../core/utils/view_helper.dart';
import '../routes/app_pages.dart';
import 'app_button.dart';

class UnauthenticatedPlaceholder extends StatelessWidget {
  const UnauthenticatedPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            AppAnimation.login.value,
            height: Get.height * 0.3,
          ),
          verticalSpace(8),
          Text(
            'Oopppss',
            style: theme.textTheme.titleLarge,
          ),
          verticalSpace(8),
          const Text(
              'Anda harus masuk terlebih dahulu!'),
          verticalSpace(8),
          AppButton(
            size: ButtonSize.large,
            label: 'Masuk',
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
