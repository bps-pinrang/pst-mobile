import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pst_online/app/core/exceptions/app_exception.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:pst_online/app/data/models/api_meta.dart';
import 'package:pst_online/app/data/models/api_response.dart';
import 'package:pst_online/app/data/models/infographic.dart';
import 'package:pst_online/app/data/models/news.dart';
import 'package:pst_online/app/data/models/news_category.dart';
import 'package:pst_online/app/data/models/publication.dart';
import 'package:pst_online/app/routes/bps_api_routes.dart';

import '../models/dynamic_table/data_response.dart';
import '../models/failure.dart';

class ApiProvider extends GetConnect {
  String appId = '';
  final GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = FlutterConfig.get(kEnvKeyBPSApiBaseUrl);
    httpClient.timeout = 30.seconds;
  }

  void _getToken() {
    appId = FlutterConfig.get(kEnvKeyBPSApiAppId);
  }

  Future<Either<Failure, T>> _getData<T>({
    required String route,
    required Map<String, dynamic> queries,
    required T Function(String responseBody) responseTransformer,
    String? domain,
  }) async {
    try {
      _getToken();
      queries[kDataKeyKey] = appId;
      queries[kDataKeyLang] = _getLang[Get.deviceLocale?.languageCode ?? 'id'];
      if (domain == null) {
        queries[kDataKeyDomain] = FlutterConfig.get(kEnvKeyDomain);
      }

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
        if (response.body[kJsonKeyDataAvailability] == 'list-not-available') {
          throw HttpException(
            'Data tidak ditemukan!',
            uri: response.request?.url,
          );
        }
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

  Future<Either<Failure, ApiResponse<List<Infographic>>>> loadInfographics(
      int page,
      {String? keyword}) async {
    var queries = {
      kDataKeyModel: 'infographic',
      kDataKeyPage: page.toString(),
    };

    queries.addIf(
      keyword != null && keyword.isNotEmpty,
      kDataKeyKeyword,
      keyword.toString(),
    );

    final response = await _getData(
      route: BpsApiRoutes.list,
      queries: queries,
      responseTransformer: (data) {
        final decoded = jsonDecode(data);
        final resp = decoded[kJsonKeyData][1] as List<dynamic>;
        final infographics = resp.map((e) => Infographic.fromJson(e)).toList();
        final apiResponse = ApiResponse(
          data: infographics,
          dataAvailability: decoded[kJsonKeyDataAvailability],
          status: decoded[kJsonKeyStatus],
          meta: ApiMeta.fromJson(decoded[kJsonKeyData][0]),
        );

        return apiResponse;
      },
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(data),
    );
  }

  Future<Either<Failure, ApiResponse<List<NewsCategory>>>>
      loadNewsCategories() async {
    var queries = {
      kDataKeyModel: 'newscategory',
    };

    final response = await _getData(
      route: BpsApiRoutes.list,
      queries: queries,
      responseTransformer: (data) {
        final decoded = jsonDecode(data);
        final resp = decoded[kJsonKeyData][1] as List<dynamic>;
        final newsCategories =
            resp.map((e) => NewsCategory.fromJson(e)).toList();
        final apiResponse = ApiResponse(
          data: newsCategories,
          dataAvailability: decoded[kJsonKeyDataAvailability],
          status: decoded[kJsonKeyStatus],
          meta: ApiMeta.fromJson(decoded[kJsonKeyData][0]),
        );

        return apiResponse;
      },
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(data),
    );
  }

  Future<Either<Failure, ApiResponse<List<News>>>> loadNews(
    int page, {
    String? keyword,
    String? newsCategory,
    String? year,
    String? month,
  }) async {
    var queries = {
      kDataKeyModel: 'news',
      kDataKeyPage: page.toString(),
    };

    queries.addIf(
      keyword != null && keyword.isNotEmpty,
      kDataKeyKeyword,
      keyword.toString(),
    );
    queries.addIf(
      newsCategory != null && newsCategory.isNotEmpty,
      kDataKeyNewsCat,
      newsCategory.toString(),
    );

    queries.addIf(
      year != null && year.isNotEmpty,
      kDataKeyYear,
      year.toString(),
    );

    queries.addIf(
      month != null && month.isNotEmpty,
      kDataKeyMonth,
      month.toString().padLeft(2, '0'),
    );





    final response = await _getData(
      route: BpsApiRoutes.list,
      queries: queries,
      responseTransformer: (data) {
        final decoded = jsonDecode(data);
        final resp = decoded[kJsonKeyData][1] as List<dynamic>;
        final news = resp.map((e) => News.fromJson(e)).toList();
        final apiResponse = ApiResponse(
          data: news,
          dataAvailability: decoded[kJsonKeyDataAvailability],
          status: decoded[kJsonKeyStatus],
          meta: ApiMeta.fromJson(decoded[kJsonKeyData][0]),
        );

        return apiResponse;
      },
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(data),
    );
  }

  Future<Either<Failure, ApiResponse<News>>> loadNewsDetail(
      String id) async {
    var queries = {
      kDataKeyModel: 'news',
      kDataKeyId: id,
    };

    final response = await _getData(
      route: BpsApiRoutes.view,
      queries: queries,
      responseTransformer: (data) {
        final decoded = jsonDecode(data);
        final resp = decoded[kJsonKeyData];
        final news = News.fromJson(resp);
        final apiResponse = ApiResponse(
          data: news,
          dataAvailability: decoded[kJsonKeyDataAvailability],
          status: decoded[kJsonKeyStatus],
        );

        return apiResponse;
      },
    );

    return response.fold(
          (failure) => Left(failure),
          (data) => Right(data),
    );
  }

  Future<Either<Failure, ApiResponse<List<Publication>>>> loadPublications(
    int page, {
    String? keyword,
    int? year,
  }) async {
    var queries = <String, String?>{
      kDataKeyModel: 'publication',
      kDataKeyPage: page.toString(),
    };

    queries.addIf(
      keyword != null && keyword.isNotEmpty,
      kDataKeyKeyword,
      keyword,
    );

    queries.addIf(
      year != null,
      kDataKeyYear,
      year.toString(),
    );

    final response = await _getData(
      route: BpsApiRoutes.list,
      queries: queries,
      responseTransformer: (data) {
        final decoded = jsonDecode(data);
        final resp = decoded[kJsonKeyData][1] as List<dynamic>;
        final publications = resp.map((e) => Publication.fromJson(e)).toList();
        final apiResponse = ApiResponse(
          data: publications,
          dataAvailability: decoded[kJsonKeyDataAvailability],
          status: decoded[kJsonKeyStatus],
          meta: ApiMeta.fromJson(decoded[kJsonKeyData][0]),
        );

        return apiResponse;
      },
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(data),
    );
  }

  Future<Either<Failure, ApiResponse<Publication>>> loadPublication(
      String id) async {
    var queries = <String, String?>{
      kDataKeyModel: 'publication',
      kDataKeyId: id,
    };

    final response = await _getData(
      route: BpsApiRoutes.view,
      queries: queries,
      responseTransformer: (data) {
        final decoded = jsonDecode(data);
        final resp = decoded[kJsonKeyData];
        final publication = Publication.fromJson(resp);
        final apiResponse = ApiResponse(
          data: publication,
          dataAvailability: decoded[kJsonKeyDataAvailability],
          status: decoded[kJsonKeyStatus],
        );

        return apiResponse;
      },
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(data),
    );
  }

  Future<Either<Failure, DataResponse>> loadData({
    String? variable,
    String? derivedVariable,
    String? verticalVariable,
    String? period,
    String? derivedPeriod,
  }) async {
    var queries = {
      kDataKeyModel: 'data',
    };

    queries.addIf(
      variable != null && variable.isNotEmpty,
      kDataKeyVar,
      variable.toString(),
    );

    queries.addIf(
      derivedVariable != null && derivedVariable.isNotEmpty,
      kDataKeyTurVar,
      derivedVariable.toString(),
    );

    queries.addIf(
      verticalVariable != null && verticalVariable.isNotEmpty,
      kDataKeyVerVar,
      verticalVariable.toString(),
    );

    queries.addIf(
      period != null && period.isNotEmpty,
      kDataKeyTh,
      period.toString(),
    );

    queries.addIf(
      derivedPeriod != null && derivedPeriod.isNotEmpty,
      kDataKeyTurTh,
      derivedPeriod.toString(),
    );

    final response = await _getData(
      route: BpsApiRoutes.list,
      queries: queries,
      responseTransformer: (data) {
        final decoded = jsonDecode(data);
        final dataResponse = DataResponse.fromJson(decoded);
        return dataResponse;
      },
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(data),
    );
  }

  Map<String, String> get _getLang => {
        'id': 'ind',
        'en': 'eng',
      };
}
