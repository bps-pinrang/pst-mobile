// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) => News(
      id: json['news_id'] as int,
      categoryName: json['newscat_name'] as String?,
      categoryId: json['newscat_id'] as String?,
      title: json['title'] as String,
      type: json['news_type'] as String?,
      news: json['news'] as String,
      picture: json['picture'] as String?,
      releaseDate: DateTime.parse(json['rl_date'] as String),
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'news_id': instance.id,
      'newscat_id': instance.categoryId,
      'newscat_name': instance.categoryName,
      'title': instance.title,
      'news_type': instance.type,
      'news': instance.news,
      'picture': instance.picture,
      'rl_date': instance.releaseDate.toIso8601String(),
    };
