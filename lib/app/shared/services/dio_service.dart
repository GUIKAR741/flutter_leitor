import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';

class DioService extends Disposable {
  final Dio client = Dio();
  DioCacheInterceptor? interceptor;
  CacheOptions? optionsCache;
  FirebaseCrashlytics? _crashlytics;

  @protected
  Future<void> initInterceptor() async {
    final directory =
        (!kIsWeb) ? await getApplicationDocumentsDirectory() : null;
    optionsCache = CacheOptions(
      store: kIsWeb
          ? MemCacheStore()
          : HiveCacheStore('${directory?.path}/hive/cache'),
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      allowPostMethod: true,
    );
    interceptor = DioCacheInterceptor(
      options: optionsCache!,
    );
    if (!kIsWeb) {
      _crashlytics = Modular.get();
    }
  }

  DioService() {
    initInterceptor().whenComplete(
      () => client.interceptors.add(
        interceptor!,
      ),
    );
  }

  bool get hasInterceptor => client.interceptors.contains(interceptor);

  Future getLink(
    String link, {
    bool returnResponse = false,
    bool? refresh = false,
    Options? options,
    String? contextError,
    CancelToken? cancelToken,
  }) async {
    Response response;
    try {
      response = await client.get(
        link,
        cancelToken: cancelToken,
        options: hasInterceptor
            ? optionsCache
                ?.copyWith(
                  maxStale: const Nullable(Duration(days: 10)),
                  policy:
                      refresh != null && refresh ? CachePolicy.refresh : null,
                )
                .toOptions()
                .copyWith(
                  contentType: options?.contentType,
                  extra: options?.extra,
                  followRedirects: options?.followRedirects,
                  headers: options?.headers ??
                      (kIsWeb
                          ? {
                              // 'User-Agent':
                              //     'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36'
                            }
                          : {}),
                  listFormat: options?.listFormat,
                  maxRedirects: options?.maxRedirects,
                  method: options?.method,
                  receiveDataWhenStatusError:
                      options?.receiveDataWhenStatusError,
                  receiveTimeout: options?.receiveTimeout,
                  requestEncoder: options?.requestEncoder,
                  responseDecoder: options?.responseDecoder,
                  responseType: options?.responseType,
                  sendTimeout: options?.sendTimeout,
                  validateStatus: options?.validateStatus,
                )
            : null,
      );
    } on DioError {
      if (hasInterceptor) {
        _crashlytics?.log(
          contextError!,
        );
      }
      rethrow;
    }
    return returnResponse ? response : response.data;
  }

  Future postLink(
    String link, {
    dynamic data,
    bool returnResponse = false,
    bool? refresh = false,
    Options? options,
    String? contextError,
    CancelToken? cancelToken,
  }) async {
    Response response;
    try {
      response = await client.post(
        link,
        data: data,
        cancelToken: cancelToken,
        options: hasInterceptor
            ? optionsCache
                ?.copyWith(
                  maxStale: const Nullable(Duration(days: 10)),
                  policy:
                      refresh != null && refresh ? CachePolicy.refresh : null,
                )
                .toOptions()
                .copyWith(
                  contentType: options?.contentType,
                  extra: options?.extra,
                  followRedirects: options?.followRedirects,
                  headers: options?.headers,
                  listFormat: options?.listFormat,
                  maxRedirects: options?.maxRedirects,
                  method: options?.method,
                  receiveDataWhenStatusError:
                      options?.receiveDataWhenStatusError,
                  receiveTimeout: options?.receiveTimeout,
                  requestEncoder: options?.requestEncoder,
                  responseDecoder: options?.responseDecoder,
                  responseType: options?.responseType,
                  sendTimeout: options?.sendTimeout,
                  validateStatus: options?.validateStatus,
                )
            : null,
      );
    } on DioError {
      if (hasInterceptor) {
        _crashlytics?.log(
          contextError!,
        );
      }
      rethrow;
    }
    return returnResponse ? response : response.data;
  }

  @override
  void dispose() {
    client.close();
  }
}
