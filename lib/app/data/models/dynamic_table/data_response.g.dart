// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataResponse _$DataResponseFromJson(Map<String, dynamic> json) => DataResponse(
      status: json['status'] as String,
      dataAvailability: json['data-availability'] as String,
      variables: (json['var'] as List<dynamic>)
          .map((e) =>
              e == null ? null : Variable.fromJson(e as Map<String, dynamic>))
          .toList(),
      derivedVariables: (json['turvar'] as List<dynamic>)
          .map((e) => e == null
              ? null
              : DerivedVariable.fromJson(e as Map<String, dynamic>))
          .toList(),
      verticalVariableLabel: json['labelvervar'] as String?,
      verticalVariables: (json['vervar'] as List<dynamic>)
          .map((e) => e == null
              ? null
              : VerticalVariable.fromJson(e as Map<String, dynamic>))
          .toList(),
      dataPeriods: (json['tahun'] as List<dynamic>)
          .map((e) => DataPeriod.fromJson(e as Map<String, dynamic>))
          .toList(),
      derivedDataPeriods: (json['turtahun'] as List<dynamic>)
          .map((e) => DerivedDataPeriod.fromJson(e as Map<String, dynamic>))
          .toList(),
      data: json['datacontent'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$DataResponseToJson(DataResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data-availability': instance.dataAvailability,
      'var': instance.variables,
      'turvar': instance.derivedVariables,
      'labelvervar': instance.verticalVariableLabel,
      'vervar': instance.verticalVariables,
      'tahun': instance.dataPeriods,
      'turtahun': instance.derivedDataPeriods,
      'datacontent': instance.data,
    };
