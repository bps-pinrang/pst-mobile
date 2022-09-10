// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'institution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Institution _$InstitutionFromJson(Map<String, dynamic> json) => Institution(
      id: json['id'] as int,
      name: json['name'] as String,
      institutionCategory: json['institutionCategory'] == null
          ? null
          : InstitutionCategory.fromJson(
              json['institutionCategory'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InstitutionToJson(Institution instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'institutionCategory': instance.institutionCategory,
    };
