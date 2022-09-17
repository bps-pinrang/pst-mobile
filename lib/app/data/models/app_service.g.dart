// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppService _$AppServiceFromJson(Map<String, dynamic> json) => AppService(
      id: json['id'] as int,
      name: json['name'] as String,
      weight: json['weight'] as int,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$AppServiceToJson(AppService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'weight': instance.weight,
      'created_at': instance.createdAt?.toIso8601String(),
    };
