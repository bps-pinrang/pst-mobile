// To parse this JSON data, do
//
//     final channelInfo = channelInfoFromJson(jsonString);

import 'dart:convert';

import 'item.dart';

import '../../../core/values/strings.dart';
import 'page_info.dart';

YoutubeApiResponse youtubeApiResponseFromJson(
  String str, {
  dynamic Function(Map<String, dynamic>)? detailsFromJson,
  dynamic Function(Map<String, dynamic>)? statisticsFromJson,
}) =>
    YoutubeApiResponse.fromJson(
      json.decode(str),
      detailsFromJson: detailsFromJson,
      statisticsFromJson: statisticsFromJson,
    );

String youtubeApiResponseToJson(YoutubeApiResponse data) =>
    json.encode(data.toJson());

class YoutubeApiResponse {
  YoutubeApiResponse({
    required this.kind,
    required this.etag,
    required this.pageInfo,
    required this.items,
    this.nextPageToken,
    this.prevPageToken,
  });

  String kind;
  String etag;
  String? nextPageToken;
  String? prevPageToken;
  PageInfo pageInfo;
  List<Item> items;

  factory YoutubeApiResponse.fromJson(
    Map<String, dynamic> json, {
    dynamic Function(Map<String, dynamic>)? detailsFromJson,
    dynamic Function(Map<String, dynamic>)? statisticsFromJson,
  }) =>
      YoutubeApiResponse(
        kind: json[kJsonKeyKind],
        etag: json[kJsonKeyEtag],
        nextPageToken: json[kJsonKeyNextPageToken],
        prevPageToken: json[kJsonKeyPrevPageToken],
        pageInfo: PageInfo.fromJson(json[kJsonKeyPageInfo]),
        items: List<Item>.from(
          json[kJsonKeyItems].map(
            (x) => Item.fromJson(
              x,
              detailsFromJson: detailsFromJson,
              statisticsFromJson: statisticsFromJson,
            ),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        kJsonKeyKind: kind,
        kJsonKeyEtag: etag,
        kJsonKeyNextPageToken: nextPageToken,
        kJsonKeyPrevPageToken: prevPageToken,
        kJsonKeyPageInfo: pageInfo.toJson(),
        kJsonKeyItems: List<dynamic>.from(items.map((x) => x.toJson())),
      };
}
