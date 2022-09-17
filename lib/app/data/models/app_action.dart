// ignore_for_file: unused_import, depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'app_action.g.dart';

@JsonSerializable()
class AppAction {
  final int id;
  final String name;

  AppAction({
    required this.id,
    required this.name,
  });

  factory AppAction.fromJson(Map<String, dynamic> json) =>
      _$AppActionFromJson(json);

  Map<String, dynamic> toJson() => _$AppActionToJson(this);
}
