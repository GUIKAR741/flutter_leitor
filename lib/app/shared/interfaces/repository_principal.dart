import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_leitor/app/shared/services/dio_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

abstract class IRepositoryPrincipal extends Disposable {
  final DioService dio;
  final Future<Box<String>> _box = Hive.openBox<String>('data');

  IRepositoryPrincipal(this.dio);

  @protected
  Future<Box<String>> get box => _box;

  Future<String> verificaData() async {
    dynamic response;
    try {
      response = await dio.getLink(
        "https://leitor-mangas-flutter.firebaseio.com/dados/atualizacao.json",
        contextError: "Falha ao Pegar Data",
        refresh: true,
      );
    } on DioError catch (e) {
      if (e.request == null) return '';
    }
    return response[response.keys.elementAt(0)]['data'];
  }

  Future<List<TituloModel>> pegarListagem({bool refresh = false});

  @override
  @mustCallSuper
  void dispose() async {
    (await _box).close();
  }
}
