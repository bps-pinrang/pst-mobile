// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usage_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsageHistory _$UsageHistoryFromJson(Map<String, dynamic> json) => UsageHistory(
      id: json['id'] as int,
      userId: json['user_id'] as String,
      service: AppService.fromJson(json['service'] as Map<String, dynamic>),
      itemType: json['item_type'] as String,
      itemName: json['item_name'] as String,
      action: AppAction.fromJson(json['action'] as Map<String, dynamic>),
      accessDate: DateTime.parse(json['access_date'] as String),
    );

Map<String, dynamic> _$UsageHistoryToJson(UsageHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'service': instance.service.toJson(),
      'item_name': instance.itemName,
      'item_type': instance.itemType,
      'access_date': instance.accessDate.toIso8601String(),
      'action': instance.action.toJson(),
    };
