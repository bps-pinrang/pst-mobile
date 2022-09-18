// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticTable _$StatisticTableFromJson(Map<String, dynamic> json) =>
    StatisticTable(
      id: json['table_id'] as int,
      title: json['title'] as String,
      subjectId: json['subj_id'] as int?,
      subId: json['sub_id'] as int?,
      subject: json['subj'] as String?,
      table: json['table'] as String?,
      size: json['size'] as String,
      updateDate: DateTime.parse(json['updt_date'] as String),
      createdAt: json['cr_date'] == null
          ? null
          : DateTime.parse(json['cr_date'] as String),
      excel: json['excel'] as String,
    );

Map<String, dynamic> _$StatisticTableToJson(StatisticTable instance) =>
    <String, dynamic>{
      'table_id': instance.id,
      'title': instance.title,
      'subj_id': instance.subjectId,
      'sub_id': instance.subId,
      'subj': instance.subject,
      'size': instance.size,
      'table': instance.table,
      'updt_date': instance.updateDate.toIso8601String(),
      'cr_date': instance.createdAt?.toIso8601String(),
      'excel': instance.excel,
    };
