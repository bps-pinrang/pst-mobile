import 'package:json_annotation/json_annotation.dart';
import 'package:pst_online/app/core/values/strings.dart';

part 'statistic_table.g.dart';

@JsonSerializable()
class StatisticTable {
  @JsonKey(name: kJsonKeyTableId)
  final int id;
  final String title;
  @JsonKey(name: kJsonKeySubjId)
  final int? subjectId;
  @JsonKey(name: kJsonKeySubId)
  final int? subId;
  @JsonKey(name: kJsonKeySubj)
  final String? subject;
  final String size;
  final String? table;
  @JsonKey(name: kJsonKeyUpdtDate)
  final DateTime updateDate;
  @JsonKey(name: kJsonKeyCrDate)
  final DateTime? createdAt;
  final String excel;

  StatisticTable({
    required this.id,
    required this.title,
    this.subjectId,
    this.subId,
    this.subject,
    this.table,
    required this.size,
    required this.updateDate,
    this.createdAt,
    required this.excel,
});

  factory StatisticTable.fromJson(Map<String, dynamic> json) => _$StatisticTableFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticTableToJson(this);

}