import '../../../core/values/strings.dart';

class Localized {
  Localized({
    required this.title,
    required this.description,
  });

  String title;
  String description;

  factory Localized.fromJson(Map<String, dynamic> json) => Localized(
    title: json[kJsonKeyTitle],
    description: json[kJsonKeyDescription],
  );

  Map<String, dynamic> toJson() => {
    kJsonKeyTitle: title,
    kJsonKeyDescription: description,
  };
}