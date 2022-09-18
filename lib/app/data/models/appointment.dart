// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pst_online/app/data/models/facility.dart';
import 'package:pst_online/app/data/models/rating_category.dart';
import 'package:pst_online/app/data/models/usage.dart';

import 'app_service.dart';
import 'appointment_status.dart';

part 'appointment.g.dart';

@JsonSerializable()
class Appointment {
  final int id;
  @JsonKey(name: 'user_id')
  final String userId;
  final Facility facility;
  @JsonKey(name: 'appointment_date')
  final DateTime appointmentDate;
  @JsonKey(name: 'check_in')
  final DateTime? checkIn;
  @JsonKey(name: 'check_out')
  final DateTime? checkOut;
  final int score;
  final RatingCategory? rating;
  final String? comment;
  final String? purpose;
  final Usage usage;
  final AppointmentStatus status;
  final List<AppService> services;

  Appointment({
    required this.id,
    required this.userId,
    required this.facility,
    required this.appointmentDate,
    this.checkIn,
    this.checkOut,
    required this.score,
    this.rating,
    this.comment,
    this.purpose,
    required this.usage,
    required this.status,
    required this.services,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
