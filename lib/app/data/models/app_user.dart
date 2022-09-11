// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'education.dart';
import 'gender.dart';
import 'user_job.dart';

part 'app_user.g.dart';

@JsonSerializable()
class AppUser {
  final String id;
  @JsonKey(name: kJsonKeyNationalId)
  final String nationalId;
  final String name;
  final Gender gender;
  final DateTime birthday;
  final String phone;
  final Education education;
  final String email;
  @JsonKey(name: kJsonKeyJob)
  final UserJob userJob;

  AppUser({
    required this.id,
    required this.nationalId,
    required this.name,
    required this.gender,
    required this.birthday,
    required this.phone,
    required this.education,
    required this.email,
    required this.userJob,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}
