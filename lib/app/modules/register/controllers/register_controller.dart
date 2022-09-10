import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pst_online/app/core/enums/tables/user_profile_columns.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:pst_online/app/data/models/education.dart';
import 'package:pst_online/app/data/models/gender.dart';
import 'package:pst_online/app/data/models/institution.dart';
import 'package:pst_online/app/data/models/institution_category.dart';
import 'package:pst_online/app/data/models/job.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterController extends GetxController {
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
      print(e.toString());
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
      var result = await client.auth.signUp(
        form.control(kFormKeyEmail).value,
        form.control(kFormKeyPassword).value,
      );

      final user = result.user;
      final session = result.data?.persistSessionString;

      if (user == null && session == null) {
        throw Exception('Gagal membuat akun!');
      }

      final profileResult = await client.from(kTableUserProfiles).insert({
        UserProfileColumns.userId.key: user?.id,
        UserProfileColumns.name.key: form.control(kFormKeyName).value,
        UserProfileColumns.genderId.key: form.control(kFormKeyGenderId).value,
        UserProfileColumns.educationId.key:
            form.control(kFormKeyEducationId).value,
        UserProfileColumns.phone.key:
            (form.control(kFormKeyPhone).value as PhoneNumber)
                .getFormattedNsn(),
        UserProfileColumns.dateOfBirth.key:
            DateTime.parse(form.control(kFormKeyDateOfBirth).value),
        UserProfileColumns.nationalId.key:
            form.control(kFormKeyNationalIdentificationNumber).value,
      }).execute();
    } catch (e) {
      //
    }
  }

  @override
  void onClose() {
    form.dispose();
    super.onClose();
  }
}
