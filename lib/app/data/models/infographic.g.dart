// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'infographic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Infographic _$InfographicFromJson(Map<String, dynamic> json) => Infographic(
      id: json['inf_id'] as int,
      title: json['title'] as String,
      image: json['img'] as String,
      description: json['desc'] as String,
      categoryId: json['category'] as int,
      downloadLink: json['dl'] as String,
    );

Map<String, dynamic> _$InfographicToJson(Infographic instance) =>
    <String, dynamic>{
      'inf_id': instance.id,
      'title': instance.title,
      'img': instance.image,
      'desc': instance.description,
      'category': instance.categoryId,
      'dl': instance.downloadLink,
    };
