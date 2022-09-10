import 'dart:convert';

import 'package:pst_online/app/core/values/strings.dart';

import 'api_meta.dart';

class ApiResponse<T> {
  final String status;
  final String dataAvailability;
  final T data;
  final ApiMeta? meta;

  ApiResponse({
    required this.status,
    required this.dataAvailability,
    required this.data,
    this.meta,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse<T>(
        status: json[kJsonKeyStatus],
        dataAvailability: json[kJsonKeyDataAvailability],
        data: json[kJsonKeyData][1] as T,
        meta: ApiMeta.fromJson(
          json[kJsonKeyData][0],
        ),
      );

  Map<String, dynamic> toJson() => {
        kJsonKeyStatus: status,
        kJsonKeyDataAvailability: dataAvailability,
        kJsonKeyData: jsonEncode(data),
      };
}
