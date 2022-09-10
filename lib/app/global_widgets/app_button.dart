import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pst_online/app/core/enums/button_size.dart';
import 'package:pst_online/app/core/enums/button_variant.dart';

class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    required this.size,
    this.variant = ButtonVariant.primary,
    this.elevation = 0,
    this.onPressed,
    this.enable = true,
    this.isDense = false,
    this.isBusy = false,
    this.icon,
    this.shape,
    this.label,
  }) : assert(
          icon != null || label != null,
          'Icon and Label cant be null!',
        );

  factory AppButton.primary({
    required ButtonSize buttonSize,
    double elevation = 0,
    void Function()? onPressed,
    IconData? icon,
    String? label,
    OutlinedBorder? shape,
    bool isDense = false,
    bool isBusy = false,
    bool enable = true,
  }) =>
      AppButton(
        size: buttonSize,
        elevation: elevation,
        onPressed: onPressed,
        icon: icon,
        isDense: isDense,
        shape: shape,
        label: label,
        isBusy: isBusy,
        enable: enable,
        variant: ButtonVariant.primary,
      );

  factory AppButton.secondary({
    required ButtonSize buttonSize,
    double elevation = 0,
    void Function()? onPressed,
    IconData? icon,
    String? label,
    OutlinedBorder? shape,
    bool isDense = false,
    bool isBusy = false,
    bool enable = true,
  }) =>
      AppButton(
        size: buttonSize,
        elevation: elevation,
        onPressed: onPressed,
        icon: icon,
        isDense: isDense,
        shape: shape,
        label: label,
        isBusy: isBusy,
        enable: enable,
        variant: ButtonVariant.secondary,
      );

  factory AppButton.flat({
    required ButtonSize buttonSize,
    double elevation = 0,
    void Function()? onPressed,
    IconData? icon,
    String? label,
    OutlinedBorder? shape,
    bool isDense = false,
    bool isBusy = false,
    bool enable = true,
  }) =>
      AppButton(
        size: buttonSize,
        elevation: elevation,
        onPressed: onPressed,
        icon: icon,
        isDense: isDense,
        label: label,
        shape: shape,
        isBusy: isBusy,
        enable: enable,
        variant: ButtonVariant.flat,
      );

  final ButtonSize size;
  final ButtonVariant variant;
  final double elevation;
  final void Function()? onPressed;
  final bool enable;
  final bool isDense;
  final bool isBusy;
  final IconData? icon;
  OutlinedBorder? shape;
  final String? label;

  @override
  Widget build(BuildContext context) {
    shape ??= RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    );

    final theme = Theme.of(context).colorScheme;

    var mainColor = theme.primary;
    var textColor = theme.onPrimary;
    var borderColor = theme.primary;

    if (variant == ButtonVariant.secondary) {
      mainColor = Colors.transparent;
      textColor = theme.secondary;
      borderColor = theme.secondary;
    }

    if (variant == ButtonVariant.flat) {
      mainColor = Colors.transparent;
      textColor = theme.primary;
      borderColor = Colors.transparent;
    }

    final isRound = icon != null && label == null;

    if (isRound) {
      shape = const CircleBorder();
    }

    final style = ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return variant.disabledColor;
          }

          return mainColor;
        },
      ),
      side: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return BorderSide(
            color: variant.disabledBorderColor,
          );
        }

        return BorderSide(
          color: borderColor,
        );
      }),
      elevation: MaterialStateProperty.all(elevation),
      overlayColor: MaterialStateProperty.all(mainColor.withOpacity(0.2)),
      shape: MaterialStateProperty.all(shape),
      textStyle: MaterialStateProperty.all(
        Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return variant.disabledTextColor;
        }

        return textColor;
      }),
      surfaceTintColor: MaterialStateProperty.all(textColor),
      shadowColor: MaterialStateProperty.all(mainColor.withOpacity(0.4)),
      padding: MaterialStateProperty.all(
        const EdgeInsets.all(8),
      ),
    );
    final button = _determineButton(
      style,
      textColor,
      mainColor,
      borderColor,
    );

    return SizedBox(
      width: _determineWidth(isRound),
      height: _determineHeight(isRound),
      child: button,
    );
  }

  Widget _determineButton(
    ButtonStyle style,
    Color textColor,
    Color mainColor,
    Color borderColor,
  ) {
    final loader = SpinKitFadingCircle(
      size: 30,
      color: textColor,
    );

    if (icon != null && label != null) {
      return variant == ButtonVariant.flat
          ? TextButton.icon(
              onPressed: isBusy ? () {} : onPressed,
              icon: isBusy ? loader : Icon(icon),
              label: label != null ? Text(label!) : const Text(''),
            )
          : OutlinedButton.icon(
              onPressed: isBusy ? () {} : onPressed,
              icon: isBusy ? loader : Icon(icon),
              label: label != null ? Text(label!) : const Text(''),
              style: style,
            );
    }

    if (icon != null && label == null) {
      return AnimatedContainer(
        duration: 500.milliseconds,
        decoration: BoxDecoration(
          color: onPressed != null ? mainColor : variant.disabledColor,
          shape: BoxShape.circle,
          boxShadow: elevation > 0 && onPressed != null
              ? [
                  BoxShadow(
                    color: mainColor.withOpacity(0.2),
                    spreadRadius: elevation,
                    blurRadius: elevation,
                    offset: const Offset(0, 6),
                  )
                ]
              : null,
          border: Border.all(
            color:
                onPressed != null ? borderColor : variant.disabledBorderColor,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: isBusy ? () {} : onPressed,
            child: isBusy
                ? loader
                : Icon(
                    icon,
                    color: onPressed != null
                        ? textColor
                        : variant.disabledTextColor,
                  ),
          ),
        ),
      );
    }

    return variant == ButtonVariant.flat
        ? TextButton(
            onPressed: isBusy ? () {} : onPressed,
            style: style,
            child: isBusy
                ? loader
                : Text(
                    label!,
                  ),
          )
        : OutlinedButton(
            onPressed: isBusy ? () {} : onPressed,
            style: style,
            child: isBusy
                ? loader
                : Text(
                    label!,
                  ),
          );
  }

  double _determineWidth(bool isRound) {
    if (isRound) {
      return _determineRadius;
    }

    return size.width;
  }

  double _determineHeight(bool isRound) {
    if (isRound) {
      return _determineRadius;
    }

    return isDense ? 42 : 50;
  }

  double get _determineRadius {
    switch (size) {
      case ButtonSize.small:
        return 42;
      case ButtonSize.medium:
        return 60;
      case ButtonSize.large:
      default:
        return 72;
    }
  }
}
