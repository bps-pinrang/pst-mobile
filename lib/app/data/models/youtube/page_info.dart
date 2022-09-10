import '../../../core/values/strings.dart';

class PageInfo {
  PageInfo({
    required this.totalResults,
    required this.resultsPerPage,
  });

  int totalResults;
  int resultsPerPage;

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
        totalResults: json[kJsonKeyTotalResults],
        resultsPerPage: json[kJsonKeyResultsPerPage],
      );

  Map<String, dynamic> toJson() => {
        kJsonKeyTotalResults: totalResults,
        kJsonKeyResultsPerPage: resultsPerPage,
      };
}
