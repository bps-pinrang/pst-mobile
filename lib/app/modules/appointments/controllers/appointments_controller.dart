import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:pst_online/app/core/enums/tables/appointment_columns.dart';
import 'package:pst_online/app/core/exceptions/app_exception.dart';
import 'package:pst_online/app/core/utils/helper.dart';
import 'package:pst_online/app/core/utils/view_helper.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:pst_online/app/data/models/app_service.dart';
import 'package:pst_online/app/data/models/usage.dart';
import 'package:pst_online/app/global_widgets/alert_variant.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/models/app_user.dart';

class AppointmentsController extends GetxController {
  final client = Supabase.instance.client;
  final form = FormGroup({
    kFormKeyPurpose: FormControl<String?>(),
    kFormKeyAppointmentDate: FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    kFormKeyUsageId: FormControl<int>(
      validators: [
        Validators.required,
      ],
    )
  });

  Rxn<AppUser> user = Rxn(null);
  final isProcessing = false.obs;
  final selectedDate = DateTime.now().obs;

  final isServiceError = false.obs;
  final isServiceLoading = false.obs;
  final isUsageError = false.obs;
  final isUsageLoading = false.obs;
  final usages = List<Usage>.empty(growable: true).obs;
  final services = List<AppService>.empty(growable: true).obs;
  final selectedServices = List<AppService>.empty(growable: true).obs;

  @override
  void onInit() async {
    user.value = Get.arguments[kArgumentKeyUser];
    await Future.wait([
      loadServices(),
      loadUsages(),
    ]);
    super.onInit();
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Appointment');
  }

  Future<void> loadServices() async {
    try {
      isServiceError.value = false;
      isServiceLoading.value = true;

      final result = await client.from(kTableServices).select('*').execute();

      final data = result.data as List;

      services.value = data.map((e) => AppService.fromJson(e)).toList();
    } catch (exception, stack) {
      FirebaseCrashlytics.instance.recordError(exception, stack);
      isServiceError.value = true;
    } finally {
      isServiceLoading.value = false;
    }
  }

  Future<void> loadUsages() async {
    try {
      isUsageError.value = false;
      isUsageLoading.value = true;

      final result = await client.from(kTableUsages).select('*').execute();

      final data = result.data as List;

      usages.value = data.map((e) => Usage.fromJson(e)).toList();
    } catch (exception, stack) {
      FirebaseCrashlytics.instance.recordError(exception, stack);
      isUsageError.value = true;
    } finally {
      isUsageLoading.value = false;
    }
  }

  Future<void> makeAppointment() async {
    try {
      isProcessing.value = true;
      final offset = selectedDate.value.timeZoneOffset.inHours.toString();
      final date = formatDate(
        'yyyy-MM-dd HH:mm:ss+${offset.padLeft(2, '0')}',
        selectedDate.value,
        showTimezone: false,
      );

      var result = await client
          .from(kTableAppointments)
          .select('*')
          .eq(AppointmentColumns.userId.key, user.value?.id)
          .gte(AppointmentColumns.appointmentDate.key, date)
          .single()
          .execute();

      if (result.data != null) {
        throw AppException(
          'Anda sudah memiliki jadwal kunjungan pada tanggal tersebut!',
        );
      }

      final data = form.rawValue;


      result = await client.from(kTableAppointments).insert({
        AppointmentColumns.userId.key: user.value?.id,
        AppointmentColumns.appointmentDate.key: date,
        AppointmentColumns.purpose.key: data[kFormKeyPurpose],
        AppointmentColumns.usageId.key: data[kFormKeyUsageId]
      }).execute();

      if (result.hasError) {
        throw AppException(result.error!.message);
      }

      final appointmentServices = selectedServices
          .map(
            (element) => {
              'appointment_id': result.data[0]['id'],
              'service_id': element.id,
            },
          )
          .toList();

      result = await client
          .from(kTableAppointmentServices)
          .insert(appointmentServices)
          .execute();

      if (result.hasError) {
        throw AppException(result.error!.message);
      }

      Get.back();

      showGetSnackBar(
        title: 'Berhasil!',
        variant: AlertVariant.success,
        message: 'Berhasil membuat kunjungan!',
      );
    } catch (exception, stack) {
      FirebaseCrashlytics.instance.recordError(exception, stack);
      if (exception is AppException) {
        showGetSnackBar(
          title: 'Kesalahan',
          message: exception.message,
          variant: AlertVariant.error,
        );
      } else {
        showGetSnackBar(
          title: 'Kesalahan',
          message: 'Terjadi kesalahan saat membuat kunjungan!',
          variant: AlertVariant.error,
        );
      }
    } finally {
      isProcessing.value = false;
    }
  }

  @override
  void onClose() {
    form.dispose();
    super.onClose();
  }
}
