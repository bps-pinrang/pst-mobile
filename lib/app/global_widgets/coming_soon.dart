import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/enums/app_animation.dart';
import 'lottie_with_author.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({
    super.key,
    this.title = '',
    this.message = '',
    this.semanticLabels = '',
  });

  final String title;
  final String message;
  final String semanticLabels;

  @override
  Widget build(BuildContext context) {
    return LottieWithAuthor(
      title: title.isEmpty ? 'Akan Datang' : title,
      message: message.isEmpty
          ? 'Mohon maaf, fitur ini masih dalam pengerjaan!'
          : message,
      animation: AppAnimation.construction,
      height: Get.height * 0.3,
      semanticLabel: semanticLabels.isEmpty
          ? 'Mohon maaf, fitur ini masih dalam pengerjaan'
          : semanticLabels,
    );
  }
}
