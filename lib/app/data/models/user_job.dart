// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

import 'package:pst_online/app/data/models/institution.dart';
import 'package:pst_online/app/data/models/job.dart';

part 'user_job.g.dart';

@JsonSerializable()
class UserJob {
  final int id;
  final Job job;
  @JsonKey(name: 'job_name')
  final String name;
  @JsonKey(name: 'start_date')
  final DateTime startDate;
  @JsonKey(name: 'end_date')
  final DateTime? endDate;
  final Institution institution;

  UserJob({
    required this.id,
    required this.name,
    required this.startDate,
    this.endDate,
    required this.job,
    required this.institution,
  });

  factory UserJob.fromJson(Map<String, dynamic> json) =>
      _$UserJobFromJson(json);

  Map<String, dynamic> toJson() => _$UserJobToJson(this);
}
