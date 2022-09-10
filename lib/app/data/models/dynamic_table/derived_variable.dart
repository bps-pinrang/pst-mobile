import 'package:json_annotation/json_annotation.dart';

part 'derived_variable.g.dart';

@JsonSerializable()
class DerivedVariable {
  final int val;
  final String label;

  DerivedVariable({
    required this.val,
    required this.label,
  });

  factory DerivedVariable.fromJson(Map<String, dynamic> json) => _$DerivedVariableFromJson(json);

  Map<String, dynamic> toJson() => _$DerivedVariableToJson(this);
}
