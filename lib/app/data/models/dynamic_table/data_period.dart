import 'package:json_annotation/json_annotation.dart';

part 'data_period.g.dart';

@JsonSerializable()
class DataPeriod {
  final int val;
  final String label;

  DataPeriod({
    required this.val,
    required this.label,
  });

  factory DataPeriod.fromJson(Map<String, dynamic> json) => _$DataPeriodFromJson(json);

  Map<String, dynamic> toJson() => _$DataPeriodToJson(this);
}
