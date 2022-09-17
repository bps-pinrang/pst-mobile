// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'app_service.g.dart';

@JsonSerializable()
class AppService {
  final int id;
  final String name;
  final int weight;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  AppService({
    required this.id,
    required this.name,
    required this.weight,
     this.createdAt,
  });

  factory AppService.fromJson(Map<String, dynamic> json) => _$AppServiceFromJson(json);

  Map<String,dynamic> toJson() => _$AppServiceToJson(this);
}
