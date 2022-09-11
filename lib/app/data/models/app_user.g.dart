// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      id: json['id'] as String,
      nationalId: json['national_id'] as String,
      name: json['name'] as String,
      gender: Gender.fromJson(json['gender'] as Map<String, dynamic>),
      birthday: DateTime.parse(json['birthday'] as String),
      phone: json['phone'] as String,
      education: Education.fromJson(json['education'] as Map<String, dynamic>),
      email: json['email'] as String,
      userJob: UserJob.fromJson(json['job'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'id': instance.id,
      'national_id': instance.nationalId,
      'name': instance.name,
      'gender': instance.gender.toJson(),
      'birthday': instance.birthday.toIso8601String(),
      'phone': instance.phone,
      'education': instance.education.toJson(),
      'email': instance.email,
      'job': instance.userJob.toJson(),
    };
