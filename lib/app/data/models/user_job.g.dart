// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserJob _$UserJobFromJson(Map<String, dynamic> json) => UserJob(
      id: json['id'] as int,
      name: json['job_name'] as String?,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      job: Job.fromJson(json['job'] as Map<String, dynamic>),
      institution:
          Institution.fromJson(json['institution'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserJobToJson(UserJob instance) => <String, dynamic>{
      'id': instance.id,
      'job': instance.job.toJson(),
      'job_name': instance.name,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'institution': instance.institution.toJson(),
    };
