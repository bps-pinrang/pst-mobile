import '../../../core/values/strings.dart';

class ChannelStatistics {
  ChannelStatistics({
    required this.viewCount,
    required this.subscriberCount,
    required this.hiddenSubscriberCount,
    required this.videoCount,
  });

  String viewCount;
  String subscriberCount;
  bool hiddenSubscriberCount;
  String videoCount;

  factory ChannelStatistics.fromJson(Map<String, dynamic> json) => ChannelStatistics(
        viewCount: json[kJsonKeyViewCount],
        subscriberCount: json[kJsonKeySubscriberCount],
        hiddenSubscriberCount: json[kJsonKeyHiddenSubscriberCount],
        videoCount: json[kJsonKeyVideoCount],
      );

  Map<String, dynamic> toJson() => {
        kJsonKeyViewCount: viewCount,
        kJsonKeySubscriberCount: subscriberCount,
        kJsonKeyHiddenSubscriberCount: hiddenSubscriberCount,
        kJsonKeyVideoCount: videoCount,
      };
}
