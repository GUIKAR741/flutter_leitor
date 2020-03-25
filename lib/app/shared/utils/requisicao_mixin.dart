import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_leitor/app/shared/services/dio_service.dart';

mixin RequisicaoMixin {
  @protected
  Future<String> requisicaoErroDb(
    DioService dio,
    String link, {
    bool refresh = false,
    CancelToken cancel,
  }) async {
    String data;
    try {
      data = await dio.getLink(
        link,
        refresh: refresh,
        cancelToken: cancel,
        contextError: "Falha ao Listar Titulos",
      );
      if (!data.contains("Erro ao conectar ao banco de dados")) return data;
      return requisicaoErroDb(
        dio,
        link,
        refresh: refresh,
        cancel: cancel,
      );
    } catch (e) {
      if (e.runtimeType == DioError && e.request != null) throw e;
      return requisicaoErroDb(
        dio,
        link,
        refresh: refresh,
        cancel: cancel,
      );
    }
  }
}
