import 'package:extended_image/extended_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pst_online/app/core/enums/app_logo.dart';
import 'package:pst_online/app/core/enums/button_size.dart';
import 'package:pst_online/app/core/utils/view_helper.dart';
import 'package:pst_online/app/core/values/size.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:pst_online/app/global_widgets/app_button.dart';
import 'package:pst_online/app/global_widgets/app_dropdown_field.dart';
import 'package:pst_online/app/global_widgets/app_password_field.dart';
import 'package:pst_online/app/global_widgets/app_phone_field.dart';
import 'package:pst_online/app/global_widgets/app_text_field.dart';
import 'package:pst_online/app/global_widgets/theme_toggle_button.dart';
import 'package:pst_online/app/modules/register/controllers/register_controller.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../i18n/strings.g.dart';
import '../../../data/models/institution.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final form = controller.form;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          title: ExtendedImage.asset(
            AppLogo.pstH.value,
            height: 60,
            semanticLabel: t.semantics.pstLogo,
          ),
          actions: const [
            ThemeToggleButton(),
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
                    'assets/images/register.svg',
                    width: Get.width * 0.6,
                  ),
                ),
                verticalSpace(8),
                Text(
                  'Daftar',
                  style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                verticalSpace(32),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: Get.height * 0.1,
                    maxWidth: Get.width,
                  ),
                  child: Column(
                    children: [
                      Obx(
                        () => NumberStepper(
                          activeStep: controller.currentStep.value,
                          numbers: const [1, 2, 3],
                          direction: Axis.horizontal,
                          steppingEnabled: true,
                          enableNextPreviousButtons: false,
                          scrollingDisabled: false,
                          onStepReached: (step) {
                            controller.currentStep.value = step;
                          },
                          activeStepColor: theme.colorScheme.primary,
                          stepPadding: 0,
                          numberStyle: textTheme.labelMedium!.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                          stepRadius: 12,
                          stepColor: theme.disabledColor.withOpacity(0.2),
                          lineColor: theme.disabledColor.withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: double.infinity,
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  alignment: Alignment.center,
                  child: Obx(
                    () => IndexedStack(
                      index: controller.currentStep.value,
                      sizing: StackFit.expand,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Informasi Akun',
                              style: textTheme.titleLarge,
                            ),
                            verticalSpace(16),
                            AppTextField(
                              label: 'Nama',
                              hintText: 'Nama Lengkap (Gelar jika ada)',
                              helperText: 'mis: Fulan, S.Sos.',
                              prefixIcon: LineIcons.user,
                              formControl: form.control(kFormKeyName),
                              validationMessages: {
                                ValidationMessage.required: (control) =>
                                    'Nama tidak boleh kosong!',
                                ValidationMessage.minLength: (control) {
                                  final minLength =
                                      (control as Map)['requiredLength'];
                                  return 'Nama minimal terdiri dari $minLength karakter.';
                                },
                              },
                              keyboardType: TextInputType.name,
                              onSubmitted: (control) =>
                                  form.control(kFormKeyEmail).focus(),
                            ),
                            verticalSpace(16),
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
                                  final minLength = (control
                                      as Map)[kValidationKeyRequiredLength];
                                  return 'Password minimal terdiri dari $minLength karakter!';
                                }
                              },
                              onSubmitted: (control) =>
                                  form.control(kFormKeyPasswordConfirm).focus(),
                            ),
                            verticalSpace(16),
                            AppPasswordField(
                              label: 'Konfirmasi Password',
                              formControl:
                                  form.control(kFormKeyPasswordConfirm),
                              validationMessages: {
                                ValidationMessage.required: (control) =>
                                    'Password konfirmasi tidak boleh kosong!',
                                ValidationMessage.mustMatch: (control) =>
                                    'Password konfirmasi tidak cocok!',
                              },
                              onSubmitted: (control) {
                                controller.currentStep.value = 1;
                                form
                                    .control(
                                        kFormKeyNationalIdentificationNumber)
                                    .focus();
                              },
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Informasi Pribadi',
                              style: textTheme.titleLarge,
                            ),
                            verticalSpace(16),
                            AppTextField(
                              label: 'Nomor Induk Kependudukan (NIK)',
                              hintText: 'Masukkan 16 digit nomor KTP Anda',
                              prefixIcon: LineIcons.identificationCard,
                              maxLength: 16,
                              formControl: form.control(
                                  kFormKeyNationalIdentificationNumber),
                              validationMessages: {
                                ValidationMessage.required: (control) =>
                                    'NIK tidak boleh kosong!',
                                ValidationMessage.minLength: (control) =>
                                    'NIK hanya boleh terdiri dari 16 karakter!',
                                ValidationMessage.maxLength: (control) =>
                                    'NIK hanya boleh terdiri dari 16 karakter!',
                              },
                              keyboardType: TextInputType.number,
                              onSubmitted: (control) =>
                                  form.control(kFormKeyDateOfBirth).focus(),
                            ),
                            verticalSpace(16),
                            AppTextField(
                              label: 'Tanggal Lahir',
                              prefixIcon: LineIcons.calendarAlt,
                              inputFormatters: [
                                controller.dateFormatter,
                              ],
                              hintText: 'YYYY-MM-DD',
                              formControl: form.control(kFormKeyDateOfBirth),
                              validationMessages: {
                                ValidationMessage.required: (control) =>
                                    'Tanggal Lahir tidak boleh kosong!',
                              },
                              keyboardType: TextInputType.datetime,
                              onSubmitted: (control) =>
                                  form.control(kFormKeyPhone).focus(),
                            ),
                            verticalSpace(16),
                            AppPhoneField(
                              label: 'Nomor Handphone',
                              formControl: form.control(kFormKeyPhone),
                              prefixIcon: LineIcons.phone,
                              validationMessages: {
                                ValidationMessage.minLength: (control) {
                                  return 'Nomor handphone tidak boleh kosong!';
                                },
                              },
                              onSubmitted: form.control(kFormKeyGenderId).focus,
                            ),
                            verticalSpace(16),
                            AppDrodpownField(
                              items: controller.genders.value
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(e.name),
                                    ),
                                  )
                                  .toList(),
                              value: form.control(kFormKeyGenderId).value,
                              label: 'Jenis Kelamin',
                              validationMessage: {
                                ValidationMessage.required: (control) =>
                                    'Pilih jenis kelamin terlebih dahulu!',
                              },
                              onChanged: (value) {
                                print(form.rawValue);
                              },
                              prefixIcon: LineIcons.genderless,
                              formControl: form.control(kFormKeyGenderId),
                            ),
                            verticalSpace(16),
                            AppDrodpownField(
                              items: controller.educations.value
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(e.name),
                                    ),
                                  )
                                  .toList(),
                              value: form.control(kFormKeyEducationId).value,
                              label: 'Pendidikan Terakhir',
                              validationMessage: {
                                ValidationMessage.required: (control) =>
                                    'Pilih pendidikan terakhir terlebih dahulu!',
                              },
                              onChanged: (value) {
                                print(form.rawValue);
                              },
                              prefixIcon: LineIcons.school,
                              formControl: form.control(kFormKeyEducationId),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Informasi Pekerjaan',
                              style: textTheme.titleLarge,
                            ),
                            verticalSpace(16),
                            AppDrodpownField(
                              items: controller.jobs.value
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(e.name),
                                    ),
                                  )
                                  .toList(),
                              value: form.control(kFormKeyJobId).value,
                              label: 'Pekerjaan',
                              validationMessage: {
                                ValidationMessage.required: (control) =>
                                    'Pilih pekerjaan terlebih dahulu!',
                              },
                              onChanged: (value) {
                                print(form.rawValue);
                              },
                              prefixIcon: LineIcons.alternateFileAlt,
                              formControl: form.control(kFormKeyJobId),
                            ),
                            _JobNameSection(form: form),
                            verticalSpace(16),
                            AppDrodpownField(
                              items: controller.institutionCategories.value
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(e.name),
                                    ),
                                  )
                                  .toList(),
                              value: form
                                  .control(kFormKeyInstitutionCategoryId)
                                  .value,
                              label: 'Jenis Institusi',
                              validationMessage: {
                                ValidationMessage.required: (control) =>
                                    'Pilih jenis institusi terlebih dahulu!',
                              },
                              onChanged: (value) {
                                print(form.rawValue);
                                controller.loadInstitutions(form
                                    .control(kFormKeyInstitutionCategoryId)
                                    .value);
                              },
                              prefixIcon: LineIcons.building,
                              formControl:
                                  form.control(kFormKeyInstitutionCategoryId),
                            ),
                            verticalSpace(16),
                            Obx(
                              () => _InstitutionSection(
                                form: form,
                                institutions: controller.institutions.value,
                              ),
                            ),
                            verticalSpace(16),
                            AppTextField(
                              label: 'Tanggal Mulai',
                              prefixIcon: LineIcons.calendarAlt,
                              inputFormatters: [
                                controller.dateFormatter,
                              ],
                              hintText: 'YYYY-MM-DD',
                              formControl: form.control(kFormKeyStartDate),
                              validationMessages: {
                                ValidationMessage.required: (control) =>
                                    'Tanggal Mulai tidak boleh kosong!',
                              },
                              keyboardType: TextInputType.datetime,
                              onSubmitted: (control) =>
                                  form.control(kFormKeyEndDate).focus(),
                            ),
                            verticalSpace(16),
                            AppTextField(
                              label: 'Tanggal Selesai',
                              prefixIcon: LineIcons.calendarAlt,
                              inputFormatters: [
                                controller.dateFormatter,
                              ],
                              hintText: 'YYYY-MM-DD',
                              helperText:
                                  'Kosongkan jika masih bekerja disini.',
                              formControl: form.control(kFormKeyEndDate),
                              keyboardType: TextInputType.datetime,
                              onSubmitted: (control) =>
                                  form.control(kFormKeyInstitutionId).focus(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpace(16),
                Row(
                  children: [
                    ReactiveCheckbox(
                      formControlName: kFormKeyAgree,
                      activeColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    horizontalSpace(8),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text:
                              'Dengan menekan daftar saya menyatakan bahwa saya setuju terhadap ',
                          style: textTheme.bodySmall,
                          children: [
                            TextSpan(
                              text: 'Ketentuan Penggunaan',
                              style: textTheme.bodySmall?.copyWith(
                                color: theme.primaryColorLight,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(
                                    Uri.parse(
                                      'https://pages.flycricket.io/pst-mobile/terms.html',
                                    ),
                                    mode: LaunchMode.externalApplication,
                                  );
                                },
                            ),
                            const TextSpan(text: ' & '),
                            TextSpan(
                                text: 'Kebijakan Privasi',
                                style: textTheme.bodySmall?.copyWith(
                                  color: theme.primaryColorLight,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launchUrl(
                                      Uri.parse(
                                        'https://pages.flycricket.io/pst-mobile/privacy.html',
                                      ),
                                      mode: LaunchMode.externalApplication,
                                    );
                                  })
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                verticalSpace(16),
                ReactiveFormConsumer(
                  builder: (_, formInstance, child) => Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AppButton.secondary(
                            buttonSize: ButtonSize.large,
                            label: 'Sebelumnya',
                            onPressed: controller.currentStep.value == 0
                                ? null
                                : () {
                                    controller.currentStep.value -= 1;
                                  },
                            isDense: true,
                          ),
                        ),
                        horizontalSpace(16),
                        Expanded(
                          child: AppButton.primary(
                            buttonSize: ButtonSize.large,
                            label: controller.currentStep.value == 2
                                ? 'Daftar'
                                : 'Selanjutnya',
                            onPressed: controller.currentStep.value == 2
                                ? (formInstance.valid ? () {} : null)
                                : () {
                                    controller.currentStep.value += 1;
                                  },
                            isDense: true,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                verticalSpace(32),
                Row(
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
                      semanticLabel: t.semantics.pstLogo,
                    ),
                    ExtendedImage.asset(
                      AppLogo.berakhlak.value,
                      height: 40,
                      semanticLabel: t.semantics.bpsCoreValueLogo,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InstitutionSection extends StatelessWidget {
  const _InstitutionSection({
    required this.form,
    required this.institutions,
  });

  final FormGroup form;
  final List<Institution> institutions;

  @override
  Widget build(BuildContext context) {
    if (form.control(kFormKeyInstitutionCategoryId).value == 9) {
      form.control(kFormKeyInstitutionName).setValidators([
        Validators.required,
      ]);
      form.control(kFormKeyInstitutionId).setValidators([]);
      return AppTextField(
        label: 'Nama Institusi',
        hintText: 'Masukkan nama institusi anda',
        prefixIcon: LineIcons.buildingAlt,
        formControl: form.control(kFormKeyInstitutionName),
        keyboardType: TextInputType.name,
        validationMessages: {
          ValidationMessage.required: (control) =>
              'Nama institusi tidak boleh kosong!',
        },
      );
    }

    if (institutions.isEmpty) {
      return AppDrodpownField(
        items: const [],
        value: form.control(kFormKeyInstitutionId).value,
        label: 'Tidak ada institusi untuk kategori yang dipilih!',
        onChanged: (value) {},
        prefixIcon: LineIcons.building,
        formControl: form.control(kFormKeyInstitutionId),
      );
    }

    form.control(kFormKeyInstitutionId).setValidators([
      Validators.required,
    ]);
    form.control(kFormKeyInstitutionName).setValidators([]);

    return AppDrodpownField(
      items: institutions
          .map(
            (e) => DropdownMenuItem(
              value: e.id,
              child: Text(e.name),
            ),
          )
          .toList(),
      value: form.control(kFormKeyInstitutionId).value,
      label: 'Institusi',
      validationMessage: {
        ValidationMessage.required: (control) =>
            'Pilih institusi terlebih dahulu!',
      },
      onChanged: (value) {
        print(form.rawValue);
      },
      prefixIcon: LineIcons.building,
      formControl: form.control(kFormKeyInstitutionId),
    );
  }
}

class _JobNameSection extends StatelessWidget {
  const _JobNameSection({required this.form});

  final FormGroup form;

  @override
  Widget build(BuildContext context) {
    if (form.control(kFormKeyJobId).value == 7) {
      form.control(kFormKeyJobName).setValidators([
        Validators.required,
      ]);

      return Column(
        children: [
          verticalSpace(16),
          AppTextField(
            label: 'Nama Pekerjaan',
            hintText: 'Masukkan nama pekerjaan anda',
            prefixIcon: LineIcons.alternateFileAlt,
            formControl: form.control(kFormKeyJobName),
            validationMessages: {
              ValidationMessage.required: (control) =>
                  'Nama pekerjaan tidak boleh kosong!',
            },
            keyboardType: TextInputType.name,
            onSubmitted: (control) =>
                form.control(kFormKeyInstitutionCategoryId).focus(),
          ),
        ],
      );
    }

    form.control(kFormKeyJobName).setValidators([]);

    return Container();
  }
}
