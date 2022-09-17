// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
import 'package:pst_online/app/data/models/app_action.dart';
import 'package:pst_online/app/data/models/app_service.dart';

part 'usage_history.g.dart';

@JsonSerializable()
class UsageHistory {
  final int id;
  @JsonKey(name: 'user_id')
  final String userId;
  final AppService service;
  @JsonKey(name: 'item_name')
  final String itemName;
  @JsonKey(name: 'item_type')
  final String itemType;
  @JsonKey(name: 'access_date')
  final DateTime accessDate;
  final AppAction action;

  UsageHistory({
    required this.id,
    required this.userId,
    required this.service,
    required this.itemType,
    required this.itemName,
    required this.action,
    required this.accessDate,
  });


  factory UsageHistory.fromJson(Map<String, dynamic> json) => _$UsageHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$UsageHistoryToJson(this);
}
