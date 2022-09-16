import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pst_online/app/core/enums/tables/user_job_columns.dart';
import 'package:pst_online/app/core/enums/tables/user_profile_columns.dart';
import 'package:pst_online/app/core/exceptions/app_exception.dart';
import 'package:pst_online/app/core/utils/helper.dart';
import 'package:pst_online/app/core/utils/view_helper.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:pst_online/app/data/models/education.dart';
import 'package:pst_online/app/data/models/gender.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/models/app_user.dart';
import '../../../data/models/user_job.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final box = GetStorage();
  final client = Supabase.instance.client;

  final isProcessing = false.obs;

  final FormGroup form = FormGroup({
    kFormKeyEmail: FormControl(
      validators: [
        Validators.required,
        Validators.email,
      ],
    ),
    kFormKeyPassword: FormControl(
      validators: [
        Validators.required,
        Validators.minLength(8),
      ],
    ),
  });

  Future<void> login() async {
    try {
      isProcessing.value = true;

      final data = form.rawValue;

      var result = await client.auth.signIn(
        email: data[kFormKeyEmail].toString(),
        password: data[kFormKeyPassword].toString(),
      );

      if (result.error != null) {
        throw AppException(result.error!.message);
      }

      final user = result.user;
      final token = result.data?.accessToken;
      final session = result.data?.persistSessionString;

      if (user == null && session == null) {
        throw AppException('Kesalahan tidak diketahui');
      }

      final profileResult = await client
          .from(kTableUserProfiles)
          .select(
              '*,gender: gender_id (id, name), education: education_id (id, name)')
          .eq(UserProfileColumns.userId.key, user!.id)
          .single()
          .execute();

      final userJobResult = await client
          .from(kTableUserJobs)
          .select(
              '*,institution:institution_id (id,name, institution_category: category_id (id,name)), job:job_id (id,name)')
          .eq(UserJobColumns.userId.key, user.id)
          .is_(UserJobColumns.endDate.key, null)
          .single()
          .execute();

      final job = UserJob.fromJson(userJobResult.data);

      final appUserData = {
        kJsonKeyId: user.id,
        kJsonKeyName: profileResult.data[UserProfileColumns.name.key],
        kJsonKeyGender: Gender.fromJson(
                profileResult.data[kJsonKeyGender] as Map<String, dynamic>)
            .toJson(),
        kJsonKeyBirthday:
            profileResult.data[UserProfileColumns.dateOfBirth.key],
        kJsonKeyEmail: user.email,
        kJsonKeyNationalId:
            profileResult.data[UserProfileColumns.nationalId.key],
        kJsonKeyPhone: profileResult.data[UserProfileColumns.phone.key],
        kJsonKeyEducation: Education.fromJson(
                profileResult.data[kJsonKeyEducation] as Map<String, dynamic>)
            .toJson(),
        kJsonKeyJob: job.toJson(),
      };

      final AppUser appUser = AppUser.fromJson(appUserData);
      box.write(kStorageKeyToken, token);
      box.write(kStorageKeySession, session);
      box.write(kStorageKeyUser, jsonEncode(appUser.toJson()));
      registerOneSignalUser(appUser);
      await Future.wait([
        FirebaseAnalytics.instance.logLogin(
          loginMethod: 'Email',
          callOptions: AnalyticsCallOptions(
            global: true,
          ),
        ),
        FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Login'),
      ]);

      showGetSnackBar(
        title: 'Berhasil masuk!',
        message: 'Selamat datang kembali ${appUser.name}',
        variant: 'success',
      );

      Get.offAllNamed(Routes.home);
    } catch (e) {
      print(e.toString());
      client.auth.signOut();
      box.remove(kStorageKeyUser);
      box.remove(kStorageKeyToken);
      box.remove(kStorageKeySession);
      showGetSnackBar(
        title: 'Kesalahan!',
        message: 'Gagal masuk ke akun anda: ${e.toString()}',
        variant: 'error',
      );
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
