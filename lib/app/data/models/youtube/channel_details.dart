import '../../../core/values/strings.dart';
import 'related_playlist.dart';

class ChannelDetails {
  ChannelDetails({
    required this.relatedPlaylists,
  });

  RelatedPlaylists relatedPlaylists;

  factory ChannelDetails.fromJson(Map<String, dynamic> json) => ChannelDetails(
        relatedPlaylists: RelatedPlaylists.fromJson(json[kJsonKeyRelatedPlaylists]),
      );

  Map<String, dynamic> toJson() => {
        kJsonKeyRelatedPlaylists: relatedPlaylists.toJson(),
      };
}
