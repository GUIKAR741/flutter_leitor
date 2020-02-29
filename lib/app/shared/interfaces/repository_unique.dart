import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../models/titulo_model.dart';
import '../services/dio_service.dart';

abstract class IRepositoryUnique extends Disposable {
  final DioService dio = Modular.get<DioService>();

  Future<List> listarTitulo(TituloModel titulo, {CancelToken cancel});
  Future<List<String>> imagens(String link, {CancelToken cancel});
}
