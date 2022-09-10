import '../../../core/values/strings.dart';
import 'localized.dart';
import 'thumbnails.dart';

class Snippet {
  Snippet({
    required this.title,
    required this.description,
    required this.publishedAt,
    required this.thumbnails,
    required this.localized,
    required this.country,
  });

  String title;
  String description;
  DateTime publishedAt;
  Thumbnails thumbnails;
  Localized? localized;
  String? country;

  factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
        title: json[kJsonKeyTitle],
        description: json[kJsonKeyDescription],
        publishedAt: DateTime.parse(json[kJsonKeyPublishedAt]),
        thumbnails: Thumbnails.fromJson(json[kJsonKeyThumbnails]),
        localized: json.containsKey(kJsonKeyLocalized)
            ? Localized.fromJson(json[kJsonKeyLocalized])
            : null,
        country: json[kJsonKeyCountry],
      );

  Map<String, dynamic> toJson() => {
        kJsonKeyTitle: title,
        kJsonKeyDescription: description,
        kJsonKeyPublishedAt: publishedAt.toIso8601String(),
        kJsonKeyThumbnails: thumbnails.toJson(),
        kJsonKeyLocalized: localized?.toJson(),
        kJsonKeyCountry: country,
      };
}
