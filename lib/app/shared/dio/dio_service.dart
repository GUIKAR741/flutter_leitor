import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'interceptors_cache.dart';

class DioService extends Disposable {
  final Dio client;

  DioService(this.client) {
    this.client.interceptors.add(CacheInterceptors());
  }

  @override
  void dispose() {
    client.close();
  }
}
