import 'package:animate_do/animate_do.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:pst_online/app/core/enums/app_logo.dart';
import 'package:pst_online/app/core/enums/button_size.dart';
import 'package:pst_online/app/core/utils/view_helper.dart';
import 'package:pst_online/app/core/values/size.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:pst_online/app/global_widgets/app_button.dart';
import 'package:pst_online/app/global_widgets/app_password_field.dart';
import 'package:pst_online/app/global_widgets/app_text_field.dart';
import 'package:pst_online/app/global_widgets/theme_toggle_button.dart';
import 'package:pst_online/app/routes/app_pages.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../global_widgets/coming_soon.dart';
import '../controllers/login_controller.dart';
import '../../../../i18n/strings.g.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final form = controller.form;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return WillPopScope(
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          appBar: AppBar(
            title: FadeInLeft(
              duration: 1.seconds,
              child: ExtendedImage.asset(
                AppLogo.pstH.value,
                height: 60,
                semanticLabel: t.semantics.pstLogo,
              ),
            ),
            scrolledUnderElevation: 0.0,
            actions: [
              FadeInRight(
                duration: 1.seconds,
                child: const ThemeToggleButton(),
              )
            ],
          ),
          body: SingleChildScrollView(
            padding: kPadding16,
            child: ReactiveForm(
              formGroup: form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SvgPicture.asset(
                      'assets/images/login.svg',
                      width: Get.width * 0.6,
                    ),
                  ),
                  verticalSpace(8),
                  Text(
                    'Masuk',
                    style: textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  verticalSpace(32),
                  AppTextField(
                    label: 'Email',
                    prefixIcon: Icons.alternate_email_rounded,
                    formControl: form.control(kFormKeyEmail),
                    validationMessages: {
                      ValidationMessage.required: (control) =>
                          'Email tidak boleh kosong!',
                      ValidationMessage.email: (control) =>
                          'Email tidak valid!',
                    },
                    keyboardType: TextInputType.emailAddress,
                    onSubmitted: (control) =>
                        form.control(kFormKeyPassword).focus(),
                  ),
                  verticalSpace(16),
                  AppPasswordField(
                    label: 'Password',
                    formControl: form.control(kFormKeyPassword),
                    validationMessages: {
                      ValidationMessage.required: (control) =>
                          'Password tidak boleh kosong!',
                      ValidationMessage.minLength: (control) {
                        final minLength = (control as Map)['requiredLength'];
                        return 'Password minimal terdiri dari $minLength karakter!';
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppButton.flat(
                        buttonSize: ButtonSize.small,
                        label: 'Lupa Password?',
                        onPressed: () {
                          showBottomSheetDialog(
                            context: context,
                            content: const ComingSoon(),
                          );
                        },
                      ),
                    ],
                  ),
                  verticalSpace(16),
                  ReactiveFormConsumer(
                    builder: (_, formInstance, child) => Obx(
                      () => AppButton.primary(
                        buttonSize: ButtonSize.large,
                        label: controller.isProcessing.value
                            ? 'Memproses'
                            : 'Masuk',
                        onPressed: formInstance.valid
                            ? (controller.isProcessing.value
                                ? () {}
                                : controller.login)
                            : null,
                        isDense: true,
                        isBusy: controller.isProcessing.value,
                      ),
                    ),
                  ),
                  verticalSpace(32),
                  Stack(
                    children: [
                      const Divider(
                        thickness: 1,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          color: theme.cardColor,
                          padding: kPadding16H,
                          child: Text(
                            'Atau',
                            style: textTheme.bodyMedium,
                          ),
                        ),
                      )
                    ],
                  ),
                  verticalSpace(32),
                  AppButton.secondary(
                    buttonSize: ButtonSize.large,
                    onPressed: () {
                      Get.toNamed(Routes.register);
                    },
                    isDense: true,
                    label: 'Daftar',
                  ),
                  verticalSpace(32),
                  FadeInUp(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ExtendedImage.asset(
                          AppLogo.bpsH.value,
                          height: 40,
                          semanticLabel: t.semantics.bpsLogo,
                        ),
                        ExtendedImage.asset(
                          AppLogo.berakhlakAlt.value,
                          height: 24,
                        ),
                        ExtendedImage.asset(
                          AppLogo.berakhlak.value,
                          height: 40,
                          semanticLabel: t.semantics.bpsCoreValueLogo,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        Get.toNamed(Routes.home);
        return false;
      },
    );
  }
}
