import '../../../core/values/strings.dart';
import 'snippet.dart';

class Item {
  Item({
    required this.kind,
    required this.etag,
    required this.id,
    required this.snippet,
    required this.contentDetails,
    required this.statistics,
  });

  String kind;
  String etag;
  String id;
  Snippet snippet;
  dynamic contentDetails;
  dynamic statistics;

  factory Item.fromJson(
    Map<String, dynamic> json, {
    dynamic Function(Map<String, dynamic>)? detailsFromJson,
    dynamic Function(Map<String, dynamic>)? statisticsFromJson,
  }) =>
      Item(
        kind: json[kJsonKeyKind],
        etag: json[kJsonKeyEtag],
        id: json[kJsonKeyId],
        snippet: Snippet.fromJson(json[kJsonKeySnippet]),
        contentDetails: detailsFromJson?.call(json[kJsonKeyContentDetails]),
        statistics: statisticsFromJson?.call(json[kJsonKeyStatistics]),
      );

  Map<String, dynamic> toJson() => {
        kJsonKeyKind: kind,
        kJsonKeyEtag: etag,
        kJsonKeyId: id,
        kJsonKeySnippet: snippet.toJson(),
        kJsonKeyContentDetails: contentDetails.toJson(),
        kJsonKeyStatistics: statistics.toJson(),
      };
}
