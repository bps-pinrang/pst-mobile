// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

import 'package:pst_online/app/core/values/strings.dart';

part 'api_meta.g.dart';

@JsonSerializable()
class ApiMeta {
  @JsonKey(name: kJsonKeyPage)
  final int page;
  @JsonKey(name: kJsonKeyPages)
  final int pages;
  @JsonKey(name: kJsonKeyPerPage)
  final int perPage;
  @JsonKey(name: kJsonKeyCount)
  final int count;
  @JsonKey(name: kJsonKeyTotal)
  final int total;

  const ApiMeta({
    this.page = 1,
    this.pages = 1,
    this.perPage = 10,
    this.count = 0,
    this.total = 0,
  });

  factory ApiMeta.fromJson(Map<String, dynamic> json) =>
      _$ApiMetaFromJson(json);

  Map<String, dynamic> toJson() => _$ApiMetaToJson(this);
}
