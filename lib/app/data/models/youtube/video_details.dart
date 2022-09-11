import 'package:pst_online/app/core/values/strings.dart';

class VideoDetails {
  final String videoId;
  final DateTime publishedAt;

  VideoDetails({
    required this.videoId,
    required this.publishedAt,
  });

  factory VideoDetails.fromJson(Map<String, dynamic> json) => VideoDetails(
        videoId: json[kJsonKeyVideoId],
        publishedAt: DateTime.parse(json[kJsonKeyVideoPublishedAt]),
      );
}
