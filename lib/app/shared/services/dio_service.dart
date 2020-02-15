import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DioService extends Disposable {
  final Dio client = Modular.get<Dio>();
  Interceptor _interceptor;

  @protected
  void initInterceptor() {
    _interceptor = DioCacheManager(
      CacheConfig(),
    ).interceptor;
  }

  DioService() {
    initInterceptor();
    this.client.interceptors.add(
          _interceptor,
        );
  }

  bool get hasInterceptor => client.interceptors.contains(_interceptor);

  Future getLink(String link,
      {bool returnResponse = false,
      bool refresh = false,
      Options options,
      String contextError,
      CancelToken cancelToken}) async {
    Response response;
    try {
      response = await client.get(
        link,
        cancelToken: cancelToken,
        options: hasInterceptor
            ? buildCacheOptions(
                Duration(days: 7),
                maxStale: Duration(days: 10),
                forceRefresh: refresh,
                options: options,
              )
            : null,
      );
    } on DioError catch (e) {
      // if (hasInterceptor)
      //   Modular.get<Crashlytics>().recordError(
      //     e,
      //     s,
      //     context: contextError,
      //   );
      throw e;
    }
    return returnResponse ? response : response.data;
  }

  Future postLink(
    String link, {
    dynamic data,
    bool returnResponse = false,
    bool refresh = false,
    Options options,
    String contextError,
    CancelToken cancelToken
  }) async {
    Response response;
    try {
      response = await client.post(
        link,
        data: data,
        cancelToken: cancelToken,
        options: hasInterceptor
            ? buildCacheOptions(
                Duration(days: 7),
                maxStale: Duration(days: 10),
                forceRefresh: refresh,
                options: options,
              )
            : null,
      );
    } on DioError catch (e) {
      // if (hasInterceptor)
      //   Modular.get<Crashlytics>().recordError(
      //     e,
      //     s,
      //     context: contextError,
      //   );
      throw e;
    }
    return returnResponse ? response : response.data;
  }

  @override
  void dispose() {
    client.close();
  }
}
