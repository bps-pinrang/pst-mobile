// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'job.g.dart';

@JsonSerializable()
class Job {
  final int id;
  final String name;

  Job({required this.id, required this.name});

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

  Map<String,dynamic> toJson() => _$JobToJson(this);
}