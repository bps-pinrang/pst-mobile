// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'institution_category.g.dart';

@JsonSerializable()
class InstitutionCategory {
  final int id;
  final String name;

  InstitutionCategory({required this.id, required this.name});

  factory InstitutionCategory.fromJson(Map<String, dynamic> json) =>
      _$InstitutionCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$InstitutionCategoryToJson(this);
}
