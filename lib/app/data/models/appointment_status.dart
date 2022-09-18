// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'appointment_status.g.dart';

@JsonSerializable()
class AppointmentStatus {
  final int id;
  final String name;

  AppointmentStatus({
    required this.id,
    required this.name,
  });

  factory AppointmentStatus.fromJson(Map<String, dynamic> json) => _$AppointmentStatusFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentStatusToJson(this);
}
