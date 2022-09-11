// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'institution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Institution _$InstitutionFromJson(Map<String, dynamic> json) => Institution(
      id: json['id'] as int,
      name: json['name'] as String,
      institutionCategory: json['institution_category'] == null
          ? null
          : InstitutionCategory.fromJson(
              json['institution_category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InstitutionToJson(Institution instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'institution_category': instance.institutionCategory?.toJson(),
    };
