import 'package:json_annotation/json_annotation.dart';

part 'variable.g.dart';

@JsonSerializable()
class Variable {
  final int val;
  final String label;
  final String unit;
  final String subj;
  final String def;
  final String note;

  Variable({
    required this.val,
    required this.label,
    required this.unit,
    required this.subj,
    required this.def,
    required this.note,
  });

  factory Variable.fromJson(Map<String, dynamic> json) => _$VariableFromJson(json);

  Map<String, dynamic> toJson() => _$VariableToJson(this);
}
