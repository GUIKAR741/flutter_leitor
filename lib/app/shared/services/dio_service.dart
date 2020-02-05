import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DioService extends Disposable {
  final Dio client;

  DioService(this.client) {
    this.client.interceptors.add(
          DioCacheManager(
            CacheConfig(),
          ).interceptor,
        );
  }

  Future getLink(String link,
      {bool returnResponse = false,
      bool refresh = false,
      Options options,
      String contextError}) async {
    Response response;
    try {
      response = await client.get(
        link,
        options: buildCacheOptions(
          Duration(days: 7),
          maxStale: Duration(days: 10),
          forceRefresh: refresh,
          options: options,
        ),
      );
    } on DioError catch (e, s) {
      Modular.get<Crashlytics>().recordError(
        e,
        s,
        context: contextError,
      );
      throw e;
    }
    return returnResponse ? response : response.data;
  }

  Future postLink(String link,
      {dynamic data,
      bool returnResponse = false,
      bool refresh = false,
      Options options,
      String contextError}) async {
    Response response;
    try {
      response = await client.post(
        link,
        data: data,
        options: buildCacheOptions(
          Duration(days: 7),
          maxStale: Duration(days: 10),
          forceRefresh: refresh,
          options: options,
        ),
      );
    } on DioError catch (e, s) {
      Modular.get<Crashlytics>().recordError(
        e,
        s,
        context: contextError,
      );
      throw e;
    }
    return returnResponse ? response : response.data;
  }

  @override
  void dispose() {
    client.close();
  }
}
