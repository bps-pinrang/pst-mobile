import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pst_online/app/core/enums/app_animation.dart';

import '../core/utils/view_helper.dart';
import 'lottie_logo.dart';

class LottieWithAuthor extends StatelessWidget {
  const LottieWithAuthor({
    super.key,
    this.height = 0,
    required this.title,
    required this.message,
    required this.animation,
    required this.semanticLabel,
  });

  final double height;
  final String title;
  final String message;
  final String semanticLabel;
  final AppAnimation animation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Lottie.asset(
          animation.value,
          width: height == 0 ? Get.width * 0.6 : height,
        ),
        verticalSpace(8),
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        verticalSpace(8),
        Focus(
          autofocus: true,
          includeSemantics: true,
          child: Text(
            message,
            semanticsLabel: semanticLabel,
            style: theme.textTheme.bodySmall,
          ),
        ),
        verticalSpace(24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: LottieLogo(
                author: animation.author,
              ),
            ),
          ],
        )
      ],
    );
  }
}
