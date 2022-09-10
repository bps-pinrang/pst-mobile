
import 'package:flutter/material.dart';
import 'package:pst_online/app/core/values/color.dart';

enum ButtonVariant {
  primary(
    bgColor: kColorPrimary,
    textColor: kColorNeutral10,
    pressedColor: kColorPrimaryPressed,
    disabledTextColor: kColorNeutral10,
    disabledBorderColor: kColorNeutral10,
    borderColor: kColorPrimary,
    disabledColor: kColorNeutral40,
  ),
  flat(
    bgColor: Colors.transparent,
    textColor: kColorPrimary,
    pressedColor: kColorPrimaryBorder,
    borderColor: Colors.transparent,
    disabledTextColor: kColorNeutral50,
    disabledBorderColor: Colors.transparent,
    disabledColor: Colors.transparent,
  ),
  secondary(
    bgColor: Colors.transparent,
    textColor: kColorPrimary,
    pressedColor: kColorPrimarySurface,
    borderColor: kColorPrimary,
    disabledTextColor: kColorNeutral50,
    disabledBorderColor: kColorNeutral50,
    disabledColor: Colors.transparent,
  );

  final Color bgColor;
  final Color textColor;
  final Color disabledTextColor;
  final Color disabledBorderColor;
  final Color pressedColor;
  final Color borderColor;
  final Color disabledColor;

  const ButtonVariant({
    required this.bgColor,
    required this.textColor,
    required this.disabledTextColor,
    required this.disabledBorderColor,
    required this.borderColor,
    required this.disabledColor,
    required this.pressedColor,
  });
}
