// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Variable _$VariableFromJson(Map<String, dynamic> json) => Variable(
      val: json['val'] as int,
      label: json['label'] as String,
      unit: json['unit'] as String,
      subj: json['subj'] as String,
      def: json['def'] as String,
      note: json['note'] as String,
    );

Map<String, dynamic> _$VariableToJson(Variable instance) => <String, dynamic>{
      'val': instance.val,
      'label': instance.label,
      'unit': instance.unit,
      'subj': instance.subj,
      'def': instance.def,
      'note': instance.note,
    };
