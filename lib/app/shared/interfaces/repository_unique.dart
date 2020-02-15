import 'package:dio/dio.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_leitor/app/shared/services/dio_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class IRepositoryUnique extends Disposable {
  final DioService dio = Modular.get<DioService>();

  Future<List> listarTitulo(TituloModel titulo, {CancelToken cancel});
  Future<List<String>> imagens(String link, {CancelToken cancel});
}
