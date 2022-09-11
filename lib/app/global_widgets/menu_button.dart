import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/enums/app_icon.dart';
import '../core/values/size.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.icon,
    required this.label,
    this.bgColor,
    this.textColor,
    this.splashColor,
    required this.onTap,
  });

  final AppIcon icon;
  final String label;
  final Color? bgColor;
  final Color? textColor;
  final Color? splashColor;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return AnimatedContainer(
      duration: 300.milliseconds,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: ExtendedAssetImageProvider(
            'assets/images/pattern.png',
          ),
          fit: BoxFit.fill,
          opacity: 0.8,
        ),
        borderRadius: BorderRadius.circular(20),
        color: bgColor,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          splashColor: splashColor,
          child: Padding(
            padding: kPadding16H,
            child: Stack(
              children: [
                Positioned(
                  top: 16,
                  left: 0,
                  child: Text(
                    label.toUpperCase(),
                    style: textTheme.labelMedium?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Positioned(
                  bottom: [AppIcon.publication, AppIcon.data, AppIcon.statistic]
                          .contains(icon)
                      ? -24
                      : -12,
                  left: 0,
                  right: 0,
                  child: ExtendedImage.asset(
                    icon.value,
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
