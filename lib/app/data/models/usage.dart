// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'usage.g.dart';

@JsonSerializable()
class Usage {
  final int id;
  final String name;

  Usage({
    required this.id,
    required this.name,
  });

  factory Usage.fromJson(Map<String, dynamic> json) => _$UsageFromJson(json);

  Map<String, dynamic> toJson() => _$UsageToJson(this);
}
