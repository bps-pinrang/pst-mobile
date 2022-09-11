import 'package:json_annotation/json_annotation.dart';

part 'derived_data_period.g.dart';

@JsonSerializable()
class DerivedDataPeriod {
  final int val;
  final String label;

  DerivedDataPeriod({
    required this.val,
    required this.label,
  });

  factory DerivedDataPeriod.fromJson(Map<String, dynamic> json) =>
      _$DerivedDataPeriodFromJson(json);

  Map<String, dynamic> toJson() => _$DerivedDataPeriodToJson(this);
}
