import 'package:dio/dio.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_episodio_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../models/titulo_model.dart';
import '../services/dio_service.dart';

abstract class IRepositoryUnique extends Disposable {
  final DioService dio = Modular.get<DioService>();

  Future<List<CapEpModel>> listarTitulo(
    TituloModel titulo, {
    bool refresh,
    CancelToken cancel,
  });
  Future<List<String>> imagens(
    String link, {
    bool refresh,
    CancelToken cancel,
  });
}
