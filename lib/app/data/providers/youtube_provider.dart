import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:pst_online/app/data/models/youtube/channel_details.dart';
import 'package:pst_online/app/data/models/youtube/channel_statistics.dart';
import 'package:pst_online/app/data/models/youtube/video_details.dart';
import 'package:pst_online/app/data/models/youtube/youtube_api_response.dart';

import '../../core/exceptions/app_exception.dart';
import '../models/failure.dart';

class YoutubeProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = 'https://www.googleapis.com/youtube/v3/';
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = 30.seconds;
  }

  Future<Either<Failure, T>> _getData<T>({
    required String route,
    required Map<String, dynamic> queries,
    required T Function(String responseBody) responseTransformer,
    String? domain,
  }) async {
    try {
      final response = await get(
        route,
        query: queries,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      var result = _response(response);

      if (result == null) {
        throw const FormatException('40 - Kesalahan format!');
      }

      return Right(responseTransformer.call(result));
    } on SocketException catch (e) {
      return Left(Failure(title: 'Kesalahan!', message: e.message));
    }
  }

  String? _response(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.bodyString;
      case 400:
        throw BadRequestException(response.bodyString.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.bodyString.toString());
      case 500:
      default:
        throw FetchDataException(
            'Terjadi kesalahan saat mencoba menghubungi server!');
    }
  }

  Future<Either<Failure, YoutubeApiResponse>> getChannelInfo() async {
    try {
      Map<String, String> parameters = {
        kQueryKeyPart: 'snippet,contentDetails,statistics',
        kQueryKeyId: FlutterConfig.get(kEnvKeyYoutubeChannelId),
        kQueryKeyKey: FlutterConfig.get(kEnvKeyYoutubeApiKey),
      };

      final result = await _getData(
        route: 'channels',
        queries: parameters,
        responseTransformer: (response) => youtubeApiResponseFromJson(
          response,
          detailsFromJson: ChannelDetails.fromJson,
          statisticsFromJson: ChannelStatistics.fromJson,
        ),
      );

      return result.fold(
        (failure) => Left(failure),
        (channelInfo) => Right(channelInfo),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<Failure, YoutubeApiResponse>> getVideos({
    String playlistId = 'UUPxtgoIt9YXn5d86HwAOcWg',
    String? pageToken,
  }) async {
    try {
      Map<String, String> parameters = {
        kQueryKeyPart: 'snippet,contentDetails',
        kQueryKeyPlaylistId: playlistId,
        kQueryKeyMaxResults: '10',
        kQueryKeyKey: FlutterConfig.get(kEnvKeyYoutubeApiKey),
      };

      parameters.addIf(
        pageToken != null,
        kQueryKeyPageToken,
        pageToken.toString(),
      );

      final result = await _getData(
        route: 'playlistItems',
        queries: parameters,
        responseTransformer: (response) => youtubeApiResponseFromJson(
          response,
          detailsFromJson: VideoDetails.fromJson,
        ),
      );

      return result.fold(
        (failure) => Left(failure),
        (playlists) => Right(playlists),
      );
    } catch (e) {
      rethrow;
    }
  }
}
