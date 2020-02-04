import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'interceptors_cache.dart';

class DioService extends Disposable {
  final Dio client;

  DioService(this.client) {
    this.client.interceptors.add(CacheInterceptors());
  }

  Future<dynamic> getLink(String link) async {
    final response = await client.get(link);
    return response.data;
  }

  Future<dynamic> postLink(String link, {dynamic data}) async {
    final response = await client.post(link, data: data);
    return response.data;
  }

  @override
  void dispose() {
    client.close();
  }
}
