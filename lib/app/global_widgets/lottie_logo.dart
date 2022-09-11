import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../core/enums/app_logo.dart';
import '../core/values/color.dart';
import '../core/values/style.dart';
import '../../i18n/strings.g.dart';

class LottieLogo extends StatelessWidget {
  const LottieLogo({super.key, required this.author});
  final String author;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                t.poweredBy,
                style: kTextStyleCaption.copyWith(
                  fontSize: 8,
                ),
                semanticsLabel: '${t.poweredBy} Lottie Files',
              ),
              const SizedBox(
                width: 2,
              ),
              SvgPicture.asset(
                AppLogo.lottieFiles.value,
                width: Get.width * 0.1,
                semanticsLabel: t.semantics.lottieFilesLogo,
              ),
            ],
          ),
        ),
        FittedBox(
          child: Text.rich(
            t.animationBy(
              name: TextSpan(
                text: author,
                style: kTextStyleCaption.copyWith(
                  fontWeight: FontWeight.w700,
                  color: kColorNeutral80,
                  fontSize: 8,
                ),
              ),
            ),
            style: kTextStyleCaption.copyWith(
              fontSize: 8,
              color: kColorNeutral70,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
