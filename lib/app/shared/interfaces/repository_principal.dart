import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_leitor/app/shared/services/dio_service.dart';
import 'package:flutter_leitor/app/shared/utils/constants.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

abstract class IRepositoryPrincipal extends Disposable {
  final DioService dio = Modular.get<DioService>();
  final Future<Box<String>> _box = Hive.openBox<String>('data');

  IRepositoryPrincipal();

  @protected
  Future<Box<String>> get box => _box;

  Future<String> verificaData({CancelToken cancel}) async {
    dynamic response;
    try {
      response = await dio.getLink(ATUALIZACAO,
          contextError: "Falha ao Pegar Data",
          refresh: true,
          cancelToken: cancel);
    } on DioError catch (e) {
      if (e.request == null) return '';
    }
    return response[response.keys.elementAt(0)]['data'];
  }

  Future<List<TituloModel>> pegarListagem(
      {bool refresh = false, CancelToken cancel});

  @override
  @mustCallSuper
  Future<void> dispose() async {
    await (await _box).close();
  }
}
