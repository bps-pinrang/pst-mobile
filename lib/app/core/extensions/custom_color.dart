import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const success = Color(0xFF006B20);
const warning = Color(0xFFFFCF8C);

CustomColors lightCustomColors = const CustomColors(
  sourceSuccess: Color(0xFF006B20),
  success: Color(0xFF066E22),
  onSuccess: Color(0xFFFFFFFF),
  successContainer: Color(0xFF9BF89A),
  onSuccessContainer: Color(0xFF002105),
  sourceWarning: Color(0xFFFFCF8C),
  warning: Color(0xFF815600),
  onWarning: Color(0xFFFFFFFF),
  warningContainer: Color(0xFFFFDDB2),
  onWarningContainer: Color(0xFF291800),
);

CustomColors darkCustomColors = const CustomColors(
  sourceSuccess: Color(0xFF006B20),
  success: Color(0xFF80DB81),
  onSuccess: Color(0xFF00390D),
  successContainer: Color(0xFF005317),
  onSuccessContainer: Color(0xFF9BF89A),
  sourceWarning: Color(0xFFFFCF8C),
  warning: Color(0xFFFFBA4B),
  onWarning: Color(0xFF442B00),
  warningContainer: Color(0xFF624000),
  onWarningContainer: Color(0xFFFFDDB2),
);

/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceSuccess,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.sourceWarning,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
  });

  final Color? sourceSuccess;
  final Color? success;
  final Color? onSuccess;
  final Color? successContainer;
  final Color? onSuccessContainer;
  final Color? sourceWarning;
  final Color? warning;
  final Color? onWarning;
  final Color? warningContainer;
  final Color? onWarningContainer;

  @override
  CustomColors copyWith({
    Color? sourceSuccess,
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? sourceWarning,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
  }) {
    return CustomColors(
      sourceSuccess: sourceSuccess ?? this.sourceSuccess,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      sourceWarning: sourceWarning ?? this.sourceWarning,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceSuccess: Color.lerp(sourceSuccess, other.sourceSuccess, t),
      success: Color.lerp(success, other.success, t),
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t),
      successContainer: Color.lerp(successContainer, other.successContainer, t),
      onSuccessContainer:
          Color.lerp(onSuccessContainer, other.onSuccessContainer, t),
      sourceWarning: Color.lerp(sourceWarning, other.sourceWarning, t),
      warning: Color.lerp(warning, other.warning, t),
      onWarning: Color.lerp(onWarning, other.onWarning, t),
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t),
      onWarningContainer:
          Color.lerp(onWarningContainer, other.onWarningContainer, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///   * [CustomColors.sourceSuccess]
  ///   * [CustomColors.success]
  ///   * [CustomColors.onSuccess]
  ///   * [CustomColors.successContainer]
  ///   * [CustomColors.onSuccessContainer]
  ///   * [CustomColors.sourceWarning]
  ///   * [CustomColors.warning]
  ///   * [CustomColors.onWarning]
  ///   * [CustomColors.warningContainer]
  ///   * [CustomColors.onWarningContainer]
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(
      sourceSuccess: sourceSuccess!.harmonizeWith(dynamic.primary),
      success: success!.harmonizeWith(dynamic.primary),
      onSuccess: onSuccess!.harmonizeWith(dynamic.primary),
      successContainer: successContainer!.harmonizeWith(dynamic.primary),
      onSuccessContainer: onSuccessContainer!.harmonizeWith(dynamic.primary),
      sourceWarning: sourceWarning!.harmonizeWith(dynamic.primary),
      warning: warning!.harmonizeWith(dynamic.primary),
      onWarning: onWarning!.harmonizeWith(dynamic.primary),
      warningContainer: warningContainer!.harmonizeWith(dynamic.primary),
      onWarningContainer: onWarningContainer!.harmonizeWith(dynamic.primary),
    );
  }
}
