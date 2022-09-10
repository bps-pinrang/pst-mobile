// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'banner_model.g.dart';

@JsonSerializable()
class BannerModel {
  final int id;
  final String title;
  final String description;
  final String image;
  final String payload;

  BannerModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.payload,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => _$BannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
