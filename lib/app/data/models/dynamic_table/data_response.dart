// ignore_for_file: depend_on_referenced_packages

import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:pst_online/app/core/values/strings.dart';

import 'data_period.dart';
import 'derived_variable.dart';
import 'vertical_variable.dart';
import 'derived_data_period.dart';
import 'variable.dart';

part 'data_response.g.dart';

@JsonSerializable()
class DataResponse {
  final String status;
  @JsonKey(name: kJsonKeyDataAvailability)
  final String dataAvailability;
  @JsonKey(name: kJsonKeyVar)
  final List<Variable?> variables;
  @JsonKey(name: kJsonKeyTurVar)
  final List<DerivedVariable?> derivedVariables;
  @JsonKey(name: kJsonKeyLabelVerVar)
  final String? verticalVariableLabel;
  @JsonKey(name: kJsonKeyVerVar)
  final List<VerticalVariable?> verticalVariables;
  @JsonKey(name: kJsonKeyTahun)
  final List<DataPeriod> dataPeriods;
  @JsonKey(name: kJsonKeyTurTahun)
  final List<DerivedDataPeriod> derivedDataPeriods;
  @JsonKey(name: kJsonKeyDataContent)
  final Map<String, dynamic> data;

  DataResponse({
    required this.status,
    required this.dataAvailability,
    required this.variables,
    required this.derivedVariables,
    required this.verticalVariableLabel,
    required this.verticalVariables,
    required this.dataPeriods,
    required this.derivedDataPeriods,
    required this.data,
  });

  factory DataResponse.fromJson(Map<String, dynamic> json) => _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);
}
