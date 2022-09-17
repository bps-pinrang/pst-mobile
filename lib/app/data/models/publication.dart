// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
import 'package:pst_online/app/core/values/strings.dart';

part 'publication.g.dart';

@JsonSerializable()
class Publication {
  @JsonKey(name: kJsonKeyPubId)
  final String id;
  final String title;
  final String issn;
  @JsonKey(name: kJsonKeySchDate)
  final DateTime? scheduledDate;
  @JsonKey(name: kJsonKeyRlDate)
  final DateTime? releaseDate;
  @JsonKey(name: kJsonKeyUpdtDate)
  final DateTime? updateDate;
  final String cover;
  final String pdf;
  final String size;
  final String? abstract;
  @JsonKey(name: kJsonKeyKatNo)
  final String? catalogueNumber;
  @JsonKey(name: kJsonKeyPubNo)
  final String? publicationNumber;

  Publication({
    required this.id,
    required this.title,
    required this.issn,
    this.scheduledDate,
    this.releaseDate,
    this.updateDate,
    required this.cover,
    required this.pdf,
    required this.size,
    this.abstract,
    this.catalogueNumber,
    this.publicationNumber,
  });

  factory Publication.fromJson(Map<String, dynamic> json) =>
      _$PublicationFromJson(json);

  Map<String, dynamic> toJson() => _$PublicationToJson(this);
}
