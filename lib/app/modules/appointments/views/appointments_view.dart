import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';

import 'package:get/get.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:pst_online/app/core/enums/button_size.dart';
import 'package:pst_online/app/core/extensions/custom_color.dart';
import 'package:pst_online/app/core/utils/helper.dart';
import 'package:pst_online/app/core/utils/view_helper.dart';
import 'package:pst_online/app/core/values/size.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:pst_online/app/data/models/app_service.dart';
import 'package:pst_online/app/global_widgets/app_button.dart';
import 'package:pst_online/app/global_widgets/app_dropdown_field.dart';
import 'package:pst_online/app/global_widgets/app_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../controllers/appointments_controller.dart';
import '../../../../i18n/strings.g.dart';

class AppointmentsView extends GetView<AppointmentsController> {
  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final customColor = theme.extension<CustomColors>();
    return Scaffold(
      appBar: AppBar(
        title: Text(t.label.menu.book_appointment.replaceAll('\n', ' ')),
        scrolledUnderElevation: 10,
        surfaceTintColor: theme.canvasColor,
      ),
      body: ReactiveForm(
        formGroup: controller.form,
        child: FooterLayout(
          footer: Container(
            padding: kPadding16,
            decoration: BoxDecoration(
              color: theme.canvasColor,
              boxShadow: [
                BoxShadow(
                  color:
                      theme.shadowColor.withOpacity(Get.isDarkMode ? 0.6 : 0.1),
                  blurRadius: 6,
                )
              ],
            ),
            child: ReactiveFormConsumer(
              builder: (context, form, _) => Obx(
                () => AppButton.primary(
                  buttonSize: ButtonSize.large,
                  label: 'Simpan',
                  onPressed:
                      form.valid && controller.selectedServices.isNotEmpty
                          ? controller.makeAppointment
                          : null,
                  isBusy: controller.isProcessing.value,
                ),
              ),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: kPadding16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Buat janji kunjungan dengan mengisi formulir dibawah',
                      ),
                      verticalSpace(16),
                      Obx(
                        () {
                          final services = controller.services.value;
                          final selectedServices =
                              controller.selectedServices.value;
                          final hint = selectedServices.isEmpty
                              ? 'Pilih Layanan'
                              : '${selectedServices.length} layanan dipilih';
                          return MultiSelectDialogField<AppService>(
                            items: services
                                .map((e) =>
                                    MultiSelectItem<AppService>(e, e.name))
                                .toList(),
                            title: const Text('Pilih Layanan'),
                            barrierColor: theme.shadowColor.withOpacity(0.2),
                            buttonText: Text(hint),
                            cancelText: const Text('Batal'),
                            confirmText: const Text('Pilih'),
                            searchable: true,
                            searchHint: 'Cari Layanan',
                            selectedColor: theme.colorScheme.primaryContainer,
                            selectedItemsTextStyle:
                                textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                            itemsTextStyle: textTheme.labelSmall,
                            checkColor: customColor?.successContainer,
                            listType: MultiSelectListType.CHIP,
                            separateSelectedItems: true,
                            buttonIcon: const Icon(Icons.arrow_drop_down),
                            initialValue: selectedServices,
                            chipDisplay: MultiSelectChipDisplay(
                              scroll: true,
                              textStyle: textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                            onConfirm: (values) {
                              controller.selectedServices.value = values;
                            },
                          );
                        },
                      ),
                      verticalSpace(16),
                      Obx(
                        () => AppDrodpownField(
                          items: controller.usages
                              .map(
                                (element) => DropdownMenuItem<int>(
                                  value: element.id,
                                  child: Text(element.name),
                                ),
                              )
                              .toList(),
                          value: controller.form.control(kFormKeyUsageId).value,
                          onChanged: (value) {
                            if (value.value != 5) {
                              controller.form
                                  .control(kFormKeyPurpose)
                                  .setValidators([]);
                            } else {
                              controller.form
                                  .control(kFormKeyPurpose)
                                  .setValidators([
                                Validators.required,
                              ]);
                            }
                          },
                          label: 'Penggunaan Data/Layanan',
                          hint: 'Pilih tujuan pemanfaatan data/layanan.',
                          prefixIcon: Icons.data_usage,
                          formControl: controller.form.control(kFormKeyUsageId),
                        ),
                      ),
                      ReactiveFormConsumer(
                        builder: (context, form, _) {
                          if (form.control(kFormKeyUsageId).value != 5) {
                            return const SizedBox.shrink();
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              verticalSpace(16),
                              AppTextField(
                                label: 'Tujuan',
                                hintText: 'Tujuan berkunjung',
                                prefixIcon: Icons.note_alt_outlined,
                                formControl:
                                    controller.form.control(kFormKeyPurpose),
                                validationMessages: {
                                  ValidationMessage.required: (_) =>
                                      'Tujuan berkunjung tidak boleh kosong!',
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      verticalSpace(16),
                      AppTextField(
                        label: 'Waktu Kunjungan',
                        hintText: 'Pilih waktu kunjungan',
                        readOnly: true,
                        suffixIcon: IconButton(
                          onPressed: () {
                            DatePicker.showDatePicker(
                              context,
                              onCancel: () {},
                              minDateTime: DateTime.now(),
                              initialDateTime: controller.selectedDate.value,
                              locale: DateTimePickerLocale.id,
                              dateFormat: 'yyyy MM dd HH:mm',
                              onMonthChangeStartWithFirstDate: true,
                              pickerMode: DateTimePickerMode.datetime,
                              onConfirm: (date, event) {
                                final selectedDate = formatDate(
                                  'EEEE, dd MMMM yyyy HH:mm',
                                  date,
                                  showTimezone: false,
                                );
                                print(selectedDate);
                                controller.selectedDate.value = date;
                                controller.form
                                    .control(kFormKeyAppointmentDate)
                                    .value = selectedDate;
                              },
                            );
                          },
                          icon: const Icon(Icons.calendar_month_outlined),
                        ),
                        prefixIcon: Icons.access_time_rounded,
                        formControl:
                            controller.form.control(kFormKeyAppointmentDate),
                        validationMessages: {
                          ValidationMessage.required: (_) =>
                              'Tujuan berkunjung tidak boleh kosong!',
                        },
                      ),
                    ],
                  ),
                ),
                verticalSpace(16),
                ExtendedImage.asset('assets/images/sop_pst.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
