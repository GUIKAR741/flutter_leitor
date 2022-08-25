import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor/app/shared/models/capitulo_episodio_model.dart';
import 'package:leitor/app/shared/models/titulo_model.dart';
import 'package:leitor/app/shared/services/dio_service.dart';

abstract class IRepositoryUnique extends Disposable {
  final DioService dio = Modular.get();

  Future<List<CapEpModel>> listarTitulo(
    TituloModel titulo, {
    bool? refresh = false,
    CancelToken? cancel,
  });
  Future<List<String?>?> imagens(
    String link, {
    bool? refresh,
    CancelToken? cancel,
  });
}
