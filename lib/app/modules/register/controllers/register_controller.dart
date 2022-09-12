import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pst_online/app/core/enums/tables/institution_columns.dart';
import 'package:pst_online/app/core/enums/tables/user_job_columns.dart';
import 'package:pst_online/app/core/enums/tables/user_profile_columns.dart';
import 'package:pst_online/app/core/exceptions/app_exception.dart';
import 'package:pst_online/app/core/utils/helper.dart';
import 'package:pst_online/app/core/utils/view_helper.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:pst_online/app/data/models/app_user.dart';
import 'package:pst_online/app/data/models/education.dart';
import 'package:pst_online/app/data/models/gender.dart';
import 'package:pst_online/app/data/models/institution.dart';
import 'package:pst_online/app/data/models/institution_category.dart';
import 'package:pst_online/app/data/models/job.dart';
import 'package:pst_online/app/routes/app_pages.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/models/user_job.dart';

class RegisterController extends GetxController {
  final box = GetStorage();

  var dateFormatter = MaskTextInputFormatter(
    mask: '####-##-##',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  final FormGroup form = FormGroup(
    {
      kFormKeyEmail: FormControl<String>(
        validators: [
          Validators.required,
          Validators.email,
        ],
      ),
      kFormKeyName: FormControl<String>(validators: [
        Validators.required,
        Validators.minLength(3),
      ]),
      kFormKeyDateOfBirth: FormControl<String>(validators: [
        Validators.required,
      ]),
      kFormKeyGenderId: FormControl<int>(validators: [
        Validators.required,
      ]),
      kFormKeyEducationId: FormControl<int>(validators: [
        Validators.required,
      ]),
      kFormKeyJobId: FormControl<int>(
        validators: [
          Validators.required,
        ],
      ),
      kFormKeyInstitutionId: FormControl<int?>(),
      kFormKeyInstitutionName: FormControl<String?>(),
      kFormKeyInstitutionCategoryId: FormControl<int>(validators: [
        Validators.required,
      ]),
      kFormKeyNationalIdentificationNumber: FormControl<String>(validators: [
        Validators.required,
        Validators.minLength(16),
        Validators.maxLength(16),
      ]),
      kFormKeyAgree: FormControl<bool>(validators: [
        Validators.requiredTrue,
      ]),
      kFormKeyPhone: FormControl<PhoneNumber>(),
      kFormKeyEndDate: FormControl<String?>(),
      kFormKeyStartDate: FormControl<String?>(validators: [
        Validators.required,
      ]),
      kFormKeyPassword: FormControl(validators: [
        Validators.required,
        Validators.minLength(8),
      ]),
      kFormKeyJobName: FormControl<String?>(),
      kFormKeyPasswordConfirm: FormControl(validators: [
        Validators.required,
      ])
    },
    validators: [
      Validators.mustMatch(kFormKeyPassword, kFormKeyPasswordConfirm),
    ],
  );

  final currentStep = 0.obs;
  final isProcessing = false.obs;

  final client = Supabase.instance.client;

  final genders = List<Gender>.empty(growable: true).obs;
  final educations = List<Education>.empty(growable: true).obs;
  final institutionCategories =
      List<InstitutionCategory>.empty(growable: true).obs;
  final institutions = List<Institution>.empty(growable: true).obs;
  final jobs = List<Job>.empty(growable: true).obs;

  @override
  onInit() async {
    super.onInit();
    await Future.wait([
      loadJobs(),
      loadGenders(),
      loadEducations(),
      loadInstitutionCategories(),
    ]);
  }

  Future<void> loadGenders() async {
    try {
      final result =
          await client.from(kTableGenders).select('id,name').execute();
      genders.value =
          (result.data as List).map((e) => Gender.fromJson(e)).toList();
    } catch (e) {
      showGetSnackBar(
        title: 'Kesalahan',
        message:
            'Terjadi kesalahan saat memuat data jenis kelamin: ${e.toString()}',
        variant: 'error',
      );
    }
  }

  Future<void> loadEducations() async {
    try {
      final result =
          await client.from(kTableEducations).select('id,name').execute();
      educations.value =
          (result.data as List).map((e) => Education.fromJson(e)).toList();
    } catch (e) {
      //
    }
  }

  Future<void> loadInstitutionCategories() async {
    try {
      final result = await client
          .from(kTableInstitutionCategories)
          .select('id,name')
          .execute();
      institutionCategories.value = (result.data as List)
          .map((e) => InstitutionCategory.fromJson(e))
          .toList();
    } catch (e) {
      //
    }
  }

  Future<void> loadInstitutions(int institutionCategory) async {
    try {
      final result = await client
          .from(kTableInstitutions)
          .select('id,name')
          .eq('category_id', institutionCategory)
          .execute();
      institutions.value =
          (result.data as List).map((e) => Institution.fromJson(e)).toList();
    } catch (e) {
      //
    }
  }

  Future<void> loadJobs() async {
    try {
      final result = await client.from(kTableJobs).select('id,name').execute();
      jobs.value = (result.data as List).map((e) => Job.fromJson(e)).toList();
    } catch (e) {
      //
    }
  }

  Future<void> registerUser() async {
    try {
      isProcessing.value = true;
      final data = form.rawValue;

      var result = await client.auth.signUp(
        data[kFormKeyEmail].toString(),
        data[kFormKeyPassword].toString(),
      );

      final user = result.user;
      final session = result.data?.persistSessionString;
      final token = result.data?.accessToken;

      if (user == null && session == null) {
        throw AppException(result.error?.message ?? 'Kesalahan!');
      }

      final results = await Future.wait([
        _saveUserProfile(user?.id, data),
        _saveUserJob(user?.id, data),
      ]);

      final userJob = await client
          .from(kTableUserJobs)
          .select(
              '*,institution:institution_id (id,name, institution_category: category_id (id,name)), job:job_id (id,name)')
          .eq(UserJobColumns.id.key,
              results.last!.data[0][UserJobColumns.id.key])
          .single()
          .execute();

      final job = UserJob.fromJson(userJob.data);

      final phoneNumber = (data[kFormKeyPhone] as PhoneNumber).international;

      final appUserData = {
        kJsonKeyId: user!.id,
        kJsonKeyName: data[kFormKeyName],
        kJsonKeyGender: genders
            .firstWhere(
              (element) => element.id == data[kFormKeyGenderId],
            )
            .toJson(),
        kJsonKeyBirthday: data[kFormKeyDateOfBirth],
        kJsonKeyEmail: data[kFormKeyEmail],
        kJsonKeyNationalId: data[kFormKeyNationalIdentificationNumber],
        kJsonKeyPhone: phoneNumber,
        kJsonKeyEducation: educations
            .firstWhere((element) => element.id == data[kFormKeyEducationId])
            .toJson(),
        kJsonKeyJob: job.toJson(),
      };

      final AppUser appUser = AppUser.fromJson(appUserData);

      registerOneSignalUser(appUser);

      box.write(kStorageKeySession, session);
      box.write(kStorageKeyToken, token);
      box.write(kStorageKeyUser, jsonEncode(appUser.toJson()));

      await Future.wait([
        FirebaseAnalytics.instance.logSignUp(
          signUpMethod: 'Email',
        ),
        FirebaseAnalytics.instance.setCurrentScreen(
          screenName: 'Register',
        ),
      ]);

      showGetSnackBar(
        title: 'Pendaftaran berhasil!',
        message: 'Selamat datang ${appUser.name}',
        variant: 'success',
      );
      Get.offAllNamed(Routes.home);
    } catch (e) {
      client.auth.signOut();
      box.remove(kStorageKeyUser);
      box.remove(kStorageKeyToken);
      box.remove(kStorageKeySession);
      showGetSnackBar(
          title: 'Kesalahan!',
          message: 'Gagal menambahkan user: ${e.toString()}!',
          variant: 'error');
    } finally {
      isProcessing.value = false;
    }
  }

  Future<PostgrestResponse?> _saveUserProfile(
      String? userId, Map<String, dynamic> data) async {
    try {
      if (userId == null) {
        throw AppException('Gagal menambahkan data user!');
      }

      final phoneNumber = (data[kFormKeyPhone] as PhoneNumber).international;
      final formData = {
        UserProfileColumns.userId.key: userId,
        UserProfileColumns.name.key: data[kFormKeyName],
        UserProfileColumns.genderId.key: data[kFormKeyGenderId],
        UserProfileColumns.educationId.key: data[kFormKeyEducationId],
        UserProfileColumns.phone.key: phoneNumber,
        UserProfileColumns.dateOfBirth.key: data[kFormKeyDateOfBirth],
        UserProfileColumns.nationalId.key:
            data[kFormKeyNationalIdentificationNumber],
      };

      final profileResult =
          await client.from(kTableUserProfiles).insert(formData).execute();
      return profileResult;
    } catch (e) {
      rethrow;
    }
  }

  Future<PostgrestResponse?> _saveUserJob(
      String? userId, Map<String, dynamic> data) async {
    try {
      if (userId == null) {
        throw AppException('Gagal menambahkan data user!');
      }

      late Map<String, dynamic> userJobData;
      final endDate = data[kFormKeyEndDate] != null &&
              data[kFormKeyEndDate].toString().isNotEmpty
          ? data[kFormKeyEndDate]
          : null;
      if (data[kFormKeyInstitutionId] != null) {
        userJobData = {
          UserJobColumns.userId.key: userId,
          UserJobColumns.jobId.key: data[kFormKeyJobId],
          UserJobColumns.jobName.key: data[kFormKeyJobName],
          UserJobColumns.institutionId.key: data[kFormKeyInstitutionId],
          UserJobColumns.startDate.key: data[kFormKeyStartDate],
          UserJobColumns.endDate.key: endDate,
        };
      } else {
        final institutionData = {
          InstitutionColumns.name.key: data[kFormKeyInstitutionName],
          InstitutionColumns.categoryId.key:
              data[kFormKeyInstitutionCategoryId],
        };

        final result = await client
            .from(kTableInstitutions)
            .insert(institutionData)
            .execute();

        final Institution institution = Institution.fromJson(result.data[0]);

        userJobData = {
          UserJobColumns.userId.key: userId,
          UserJobColumns.jobId.key: data[kFormKeyJobId],
          UserJobColumns.jobName.key: data[kFormKeyJobName],
          UserJobColumns.institutionId.key: institution.id,
          UserJobColumns.startDate.key: data[kFormKeyStartDate],
          UserJobColumns.endDate.key: endDate,
        };
      }

      final result =
          await client.from(kTableUserJobs).insert(userJobData).execute();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onClose() {
    form.dispose();
    super.onClose();
  }
}
