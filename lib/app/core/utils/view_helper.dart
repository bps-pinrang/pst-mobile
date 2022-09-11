import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pst_online/app/core/enums/app_animation.dart';
import 'package:pst_online/app/core/enums/button_variant.dart';
import 'package:pst_online/app/core/extensions/custom_color.dart';
import 'package:pst_online/app/core/values/color.dart';
import 'package:pst_online/app/core/values/size.dart';
import 'package:pst_online/app/global_widgets/app_button.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../enums/button_size.dart';

Widget horizontalSpace(double spacing) => SizedBox(width: spacing);

Widget verticalSpace(double spacing) => SizedBox(height: spacing);

bool _checkIsAnythingOnScreen() {
  return Get.isSnackbarOpen || Get.isBottomSheetOpen! || Get.isDialogOpen!;
}

Future<void> showConfirmationDialog(
  BuildContext context, {
  required String title,
  required String content,
  String? confirmLabel,
  String? cancelLabel,
  String? image,
  required GestureTapCallback onConfirm,
  GestureTapCallback? onCancel,
}) async {
  try {
    if (_checkIsAnythingOnScreen()) Get.back();

    Widget buildImage = Column(
      children: [
        Lottie.asset(
          AppAnimation.warning.value,
          width: Get.width * 0.3,
          height: Get.width * 0.3,
          fit: BoxFit.cover,
        ),
        verticalSpace(16),
      ],
    );

    if (image != null) {
      buildImage = Column(
        children: [
          ExtendedImage.asset(
            image,
            width: 160,
            height: 160,
          ),
          verticalSpace(16),
        ],
      );
    }

    final theme = Theme.of(context);

    return await Get.defaultDialog(
      barrierDismissible: false,
      title: '',
      radius: 12,
      titlePadding: EdgeInsets.zero,
      content: Column(
        children: [
          buildImage,
          Text(
            title,
            style: theme.textTheme.titleLarge,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          verticalSpace(8),
          Padding(
            padding: kPadding16H,
            child: Text(
              content,
              style: theme.textTheme.caption,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      contentPadding: kPadding16H8V.copyWith(
        top: 0.0,
      ),
      actions: [
        AppButton(
          label: confirmLabel ?? 'Oke',
          onPressed: onConfirm,
          size: ButtonSize.small,
          variant: ButtonVariant.primary,
          isDense: true,
        ),
        AppButton(
          label: cancelLabel ?? 'Batal',
          onPressed: onCancel ?? Get.back,
          size: ButtonSize.small,
          variant: ButtonVariant.secondary,
          isDense: true,
        ),
      ],
    );
  } catch (e) {
    //
  }
}

Future showBottomSheetDialog({
  BuildContext? context,
  Widget Function(BuildContext context, SheetState state)? headerBuilder,
  Widget Function(BuildContext context, SheetState state)? footerBuilder,
  required Widget content,
}) async {
  Widget Function(BuildContext context, SheetState state)? header =
      headerBuilder;
  final theme = Get.theme;
  final localContext = context ?? Get.context!;
  header ??= (_, __) => Padding(
        padding: kPadding16V,
        child: Container(
          decoration: BoxDecoration(
            color: theme.disabledColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          width: 38,
          height: 8.0,
        ),
      );
  return await showSlidingBottomSheet(
    localContext,
    resizeToAvoidBottomInset: true,
    builder: (ctx) => SlidingSheetDialog(
      cornerRadius: 16,
      cornerRadiusOnFullscreen: 0,
      avoidStatusBar: true,
      headerBuilder: header,
      snapSpec: const SnapSpec(
        initialSnap: 0.8,
        snappings: [0.8, 1.0],
      ),
      builder: (_, state) => Material(
        child: Padding(
          padding: kPadding16,
          child: content,
        ),
      ),
      footerBuilder: footerBuilder,
      duration: 300.milliseconds,
    ),
  );
}

Color checkFloatingLabelColor(
    bool isFocus, bool isValid, AbstractControl formControl, ThemeData theme) {
  if (formControl.pristine && !formControl.touched) {
    return isFocus ? kColorPrimary : theme.colorScheme.onSurface;
  }

  if (!isValid && formControl.touched) {
    return theme.errorColor;
  }

  return isFocus ? kColorPrimary : theme.colorScheme.onSurface;
}

void showGetSnackBar({
  Widget? leading,
  required String title,
  required String message,
  String variant = 'info',
  double overlayBlur = 0.0,
  bool isDismissible = true,
  bool showProgressIndicator = false,
}) async {
  try {
    final textTheme = Get.textTheme;
    final theme = Get.theme;
    var bgColor = theme.primaryColor;
    final extensionColor = theme.extension<CustomColors>();

    if (variant == 'success') {
      bgColor = extensionColor!.success!;
    }

    if (variant == 'error') {
      bgColor = theme.errorColor;
    }

    if (_checkIsAnythingOnScreen()) Get.back();
    Get.showSnackbar(
      GetSnackBar(
        icon: leading,
        titleText: Text(
          title,
          style: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        borderRadius: 12,
        margin: kPadding16,
        backgroundColor: bgColor,
        duration: 3.seconds,
        isDismissible: isDismissible,
        messageText: Text(
          message,
          style: textTheme.caption?.copyWith(
            color: Colors.white,
          ),
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
        ),
        overlayBlur: overlayBlur,
        mainButton: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: Get.back,
          iconSize: 16,
          splashColor: null,
        ),
        overlayColor: theme.shadowColor.withOpacity(0.2),
        padding: kPadding8,
        snackPosition: SnackPosition.BOTTOM,
        showProgressIndicator: showProgressIndicator,
        snackStyle: SnackStyle.FLOATING,
        boxShadows: [
          BoxShadow(
            color: bgColor.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 6,
          )
        ],
      ),
    );
  } catch (e) {
    //
  }
}

Future<void> showLoadingDialog({String? label, RxDouble? progress}) async {
  if (_checkIsAnythingOnScreen()) {
    Get.back();
  }
  final theme = Get.theme;
  return Get.defaultDialog(
      title: 'Mohon Tunggu',
      titleStyle: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      barrierDismissible: false,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitFadingCircle(
                color: theme.colorScheme.primary,
                size: 30.0,
              ),
              horizontalSpace(8),
              Text(label ?? 'Memproses permintaan anda!'),
            ],
          ),
          if (progress != null) ...[
            verticalSpace(16),
            Obx(
              () => LinearPercentIndicator(
                percent: progress / 100,
                backgroundColor: kColorSuccess.withOpacity(0.4),
                progressColor: kColorSuccess,
                animateFromLastPercent: true,
                animation: true,
                animationDuration: 100,
                barRadius: const Radius.circular(12),
              ),
            ),
            verticalSpace(4),
            Obx(
              () => Text(
                '${progress.value.toPrecision(0)}%',
                textAlign: TextAlign.end,
                style: theme.textTheme.bodySmall,
              ),
            )
          ]
        ],
      ));
}
