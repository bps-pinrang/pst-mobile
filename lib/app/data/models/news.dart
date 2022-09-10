// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
import 'package:pst_online/app/core/values/strings.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  @JsonKey(name: kJsonKeyNewsId)
  final int id;
  @JsonKey(name: kJsonKeyNewsCatId)
  final String categoryId;
  @JsonKey(name: kJsonKeyNewsCatName)
  final String categoryName;
  final String title;
  @JsonKey(name: kJsonKeyNewsType)
  final String? type;
  final String news;
  final String? picture;
  @JsonKey(name: kJsonKeyRlDate)
  final DateTime releaseDate;

  const News({
    required this.id,
    required this.categoryName,
    required this.categoryId,
    required this.title,
    required this.type,
    required this.news,
    required this.picture,
    required this.releaseDate,
  });

  factory News.fromJson(Map<String, dynamic> json)  => _$NewsFromJson(json);

  Map<String, dynamic> toJson() => _$NewsToJson(this);
}
