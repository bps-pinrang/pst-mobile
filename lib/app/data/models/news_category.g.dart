// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsCategory _$NewsCategoryFromJson(Map<String, dynamic> json) => NewsCategory(
      id: json['newscat_id'] as String,
      name: json['newscat_name'] as String,
    );

Map<String, dynamic> _$NewsCategoryToJson(NewsCategory instance) =>
    <String, dynamic>{
      'newscat_id': instance.id,
      'newscat_name': instance.name,
    };
