import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:pst_online/app/core/values/size.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/enums/button_size.dart';
import '../../../core/utils/view_helper.dart';
import '../../../core/values/strings.dart';
import '../../../global_widgets/app_button.dart';
import '../../../global_widgets/app_text_field.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final form = controller.form;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
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
                  'assets/images/forgot_password.svg',
                  width: Get.width * 0.6,
                ),
              ),
              verticalSpace(8),
              Text(
                'Lupa Password?',
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              verticalSpace(8),
              Text(
                'Jangan khawatir. Silahkan masukkan alamat email yang terhubung ke akun anda pada form dibawah. Kami akan mengirimkan link untuk memperbarui password anda!',
                style: textTheme.caption,
              ),
              verticalSpace(32),
              AppTextField(
                label: 'Email',
                prefixIcon: Icons.alternate_email_rounded,
                formControl: form.control(kFormKeyEmail),
                validationMessages: {
                  ValidationMessage.required: (control) =>
                      'Email tidak boleh kosong!',
                  ValidationMessage.email: (control) => 'Email tidak valid!',
                },
                keyboardType: TextInputType.emailAddress,
              ),
              verticalSpace(32),
              ReactiveFormConsumer(
                builder: (_, formInstance, child) => Obx(
                  () => AppButton.primary(
                    buttonSize: ButtonSize.large,
                    label:
                        controller.isProcessing.value ? 'Memproses' : 'Kirim',
                    onPressed: formInstance.valid
                        ? (controller.isProcessing.value
                            ? () {}
                            : controller.sendPasswordResetEmail)
                        : null,
                    isDense: true,
                    isBusy: controller.isProcessing.value,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
