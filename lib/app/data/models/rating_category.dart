// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'rating_category.g.dart';

@JsonSerializable()
class RatingCategory {
  final int id;
  final String name;

  RatingCategory({
    required this.id,
    required this.name,
  });

  factory RatingCategory.fromJson(Map<String, dynamic> json) => _$RatingCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$RatingCategoryToJson(this);
}
