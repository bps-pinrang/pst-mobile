// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
import 'package:pst_online/app/data/models/institution_category.dart';

part 'institution.g.dart';

@JsonSerializable()
class Institution {
  final int id;
  final String name;
  @JsonKey(name: 'institution_category')
  final InstitutionCategory? institutionCategory;

  Institution({required this.id, required this.name, this.institutionCategory});

  factory Institution.fromJson(Map<String, dynamic> json) =>
      _$InstitutionFromJson(json);

  Map<String, dynamic> toJson() => _$InstitutionToJson(this);
}
