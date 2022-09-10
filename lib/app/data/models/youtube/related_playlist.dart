import '../../../core/values/strings.dart';

class RelatedPlaylists {
  RelatedPlaylists({
    required this.likes,
    required this.uploads,
  });

  String likes;
  String uploads;

  factory RelatedPlaylists.fromJson(Map<String, dynamic> json) => RelatedPlaylists(
    likes: json[kJsonKeyLikes],
    uploads: json[kJsonKeyUploads],
  );

  Map<String, dynamic> toJson() => {
    kJsonKeyLikes: likes,
    kJsonKeyUploads: uploads,
  };
}