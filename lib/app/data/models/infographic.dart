// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
import 'package:pst_online/app/core/values/strings.dart';

part 'infographic.g.dart';

@JsonSerializable()
class Infographic {
  @JsonKey(name: kJsonKeyInfId)
  final int id;
  @JsonKey(name: kJsonKeyTitle)
  final String title;
  @JsonKey(name: kJsonKeyImg)
  final String image;
  @JsonKey(name: kJsonKeyDesc)
  final String description;
  @JsonKey(name: kJsonKeyCategory)
  final int categoryId;
  @JsonKey(name: kJsonKeyDl)
  final String downloadLink;

  const Infographic({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.categoryId,
    required this.downloadLink,
  });

  factory Infographic.fromJson(Map<String, dynamic> json) => _$InfographicFromJson(json);

  Map<String, dynamic> toJson() => _$InfographicToJson(this);
}
