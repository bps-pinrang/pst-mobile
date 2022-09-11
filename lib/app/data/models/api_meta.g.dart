// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiMeta _$ApiMetaFromJson(Map<String, dynamic> json) => ApiMeta(
      page: json['page'] as int? ?? 1,
      pages: json['pages'] as int? ?? 1,
      perPage: json['per_page'] as int? ?? 10,
      count: json['count'] as int? ?? 0,
      total: json['total'] as int? ?? 0,
    );

Map<String, dynamic> _$ApiMetaToJson(ApiMeta instance) => <String, dynamic>{
      'page': instance.page,
      'pages': instance.pages,
      'per_page': instance.perPage,
      'count': instance.count,
      'total': instance.total,
    };
