// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      id: json['id'] as int,
      userId: json['user_id'] as String,
      facility: Facility.fromJson(json['facility'] as Map<String, dynamic>),
      appointmentDate: DateTime.parse(json['appointment_date'] as String),
      checkIn: json['check_in'] == null
          ? null
          : DateTime.parse(json['check_in'] as String),
      checkOut: json['check_out'] == null
          ? null
          : DateTime.parse(json['check_out'] as String),
      score: json['score'] as int,
      rating: json['rating'] == null
          ? null
          : RatingCategory.fromJson(json['rating'] as Map<String, dynamic>),
      comment: json['comment'] as String?,
      purpose: json['purpose'] as String?,
      usage: Usage.fromJson(json['usage'] as Map<String, dynamic>),
      status:
          AppointmentStatus.fromJson(json['status'] as Map<String, dynamic>),
      services: (json['services'] as List<dynamic>)
          .map((e) =>
              AppService.fromJson((e as Map<String, dynamic>)['service']))
          .toList(),
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'facility': instance.facility.toJson(),
      'appointment_date': instance.appointmentDate.toIso8601String(),
      'check_in': instance.checkIn?.toIso8601String(),
      'check_out': instance.checkOut?.toIso8601String(),
      'score': instance.score,
      'rating': instance.rating?.toJson(),
      'comment': instance.comment,
      'purpose': instance.purpose,
      'usage': instance.usage.toJson(),
      'status': instance.status.toJson(),
      'services': jsonEncode(
          instance.services.map((e) => {'service': e.toJson()}).toList()),
    };
