import 'package:dio/dio.dart';
import 'package:flutter_leitor/app/shared/dio/interceptors_cache.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CustomDio extends Disposable{
  final Dio client;

  CustomDio(this.client){
    this.client.interceptors.add(CacheInterceptors());
  }

  @override
  void dispose() {
    client.close();
  }
}
