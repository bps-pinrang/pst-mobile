// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
import 'package:pst_online/app/core/values/strings.dart';

part 'news_category.g.dart';

@JsonSerializable()
class NewsCategory {
  @JsonKey(name: kJsonKeyNewsCatId)
  final String id;
  @JsonKey(name: kJsonKeyNewsCatName)
  final String name;

  const NewsCategory({
    required this.id,
    required this.name,
  });

  factory NewsCategory.fromJson(Map<String, dynamic> json) => _$NewsCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$NewsCategoryToJson(this);
}
