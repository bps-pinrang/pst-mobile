// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Publication _$PublicationFromJson(Map<String, dynamic> json) => Publication(
      id: json['pub_id'] as String,
      title: json['title'] as String,
      issn: json['issn'] as String,
      scheduledDate: json['sch_date'] == null
          ? null
          : DateTime.parse(json['sch_date'] as String),
      releaseDate: json['rl_date'] == null
          ? null
          : DateTime.parse(json['rl_date'] as String),
      updateDate: json['updt_date'] == null
          ? null
          : DateTime.parse(json['updt_date'] as String),
      cover: json['cover'] as String,
      pdf: json['pdf'] as String,
      size: json['size'] as String,
      abstract: json['abstract'] as String?,
      catalogueNumber: json['kat_no'] as String?,
      publicationNumber: json['pub_no'] as String?,
    );

Map<String, dynamic> _$PublicationToJson(Publication instance) =>
    <String, dynamic>{
      'pub_id': instance.id,
      'title': instance.title,
      'issn': instance.issn,
      'sch_date': instance.scheduledDate?.toIso8601String(),
      'rl_date': instance.releaseDate?.toIso8601String(),
      'updt_date': instance.updateDate?.toIso8601String(),
      'cover': instance.cover,
      'pdf': instance.pdf,
      'size': instance.size,
      'abstract': instance.abstract,
      'kat_no': instance.catalogueNumber,
      'pub_no': instance.publicationNumber,
    };
