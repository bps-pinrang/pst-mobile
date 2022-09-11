// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsCategory _$NewsCategoryFromJson(Map<String, dynamic> json) => NewsCategory(
      id: json['news_cat_id'] as String,
      name: json['news_cat_name'] as String,
    );

Map<String, dynamic> _$NewsCategoryToJson(NewsCategory instance) =>
    <String, dynamic>{
      'news_cat_id': instance.id,
      'news_cat_name': instance.name,
    };
