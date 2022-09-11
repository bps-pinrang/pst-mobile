import '../../../core/values/strings.dart';

class Thumbnails {
  Thumbnails({
    required this.thumbnailsDefault,
    required this.medium,
    required this.high,
  });

  Default thumbnailsDefault;
  Default medium;
  Default high;

  factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
    thumbnailsDefault: Default.fromJson(json[kJsonKeyDefault]),
    medium: Default.fromJson(json[kJsonKeyMedium]),
    high: Default.fromJson(json[kJsonKeyHigh]),
  );

  Map<String, dynamic> toJson() => {
    kJsonKeyDefault: thumbnailsDefault.toJson(),
    kJsonKeyMedium: medium.toJson(),
    kJsonKeyHigh: high.toJson(),
  };
}

class Default {
  Default({
    required this.url,
    required this.width,
    required this.height,
  });

  String url;
  int width;
  int height;

  factory Default.fromJson(Map<String, dynamic> json) => Default(
    url: json['url'],
    width: json['width'],
    height: json['height'],
  );

  Map<String, dynamic> toJson() => {
    'url': url,
    'width': width,
    'height': height,
  };
}
