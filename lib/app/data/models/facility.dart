// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'facility.g.dart';

@JsonSerializable()
class Facility {
  final int id;
  final String name;
  final int weight;

  Facility({
    required this.id,
    required this.name,
    required this.weight,
  });

  factory Facility.fromJson(Map<String, dynamic> json) => _$FacilityFromJson(json);

  Map<String, dynamic> toJson() => _$FacilityToJson(this);
}
