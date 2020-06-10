import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DioService extends Disposable {
  final Dio client = Dio();
  DioCacheManager interceptor;
  Crashlytics _crashlytics;

  @protected
  void initInterceptor() {
    interceptor = DioCacheManager(
      CacheConfig(),
    );
    _crashlytics = Modular.get<Crashlytics>();
  }

  DioService() {
    initInterceptor();
    this.client.interceptors.add(
          interceptor.interceptor,
        );
  }

  bool get hasInterceptor => client.interceptors.contains(interceptor.interceptor);

  Future getLink(
    String link, {
    bool returnResponse = false,
    bool refresh = false,
    Options options,
    String contextError,
    CancelToken cancelToken,
  }) async {
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
      if (hasInterceptor)
        _crashlytics.log(
          contextError,
        );
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
    CancelToken cancelToken,
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
      if (hasInterceptor)
        _crashlytics.log(
          contextError,
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
