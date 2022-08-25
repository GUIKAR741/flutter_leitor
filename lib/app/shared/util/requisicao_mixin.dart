import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:leitor/app/shared/services/dio_service.dart';

mixin RequisicaoMixin {
  @protected
  Future<String> requisicaoErroDb(
    DioService dio,
    String link, {
    Options? options,
    bool? refresh = false,
    CancelToken? cancel,
  }) async {
    String data;
    try {
      data = await dio.getLink(
        link,
        refresh: refresh,
        cancelToken: cancel,
        options: options,
        contextError: "Falha ao Listar Titulos",
      );
      if (!data.contains("Erro ao conectar ao banco de dados")) return data;
      return requisicaoErroDb(
        dio,
        link,
        refresh: true,
        cancel: cancel,
      );
    } on DioError catch (_) {
      return requisicaoErroDb(
        dio,
        link,
        refresh: true,
        cancel: cancel,
      );
    }
  }
}
