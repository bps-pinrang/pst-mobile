import 'package:json_annotation/json_annotation.dart';

part 'vertical_variable.g.dart';

@JsonSerializable()
class VerticalVariable {
  final int val;
  final String label;

  VerticalVariable({
    required this.val,
    required this.label,
  });

  factory VerticalVariable.fromJson(Map<String, dynamic> json) => _$VerticalVariableFromJson(json);

  Map<String, dynamic> toJson() => _$VerticalVariableToJson(this);
}
