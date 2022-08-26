import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor/app/shared/models/titulo_model.dart';
import 'package:leitor/app/shared/services/dio_service.dart';
import 'package:leitor/app/shared/util/constants.dart';

abstract class IRepositoryPrincipal {
  final DioService dio = Modular.get();

  Future<String> verificaData({CancelToken? cancel}) async {
    dynamic response;
    try {
      response = await dio.getLink(atualizacaoLink,
          contextError: "Falha ao Pegar Data",
          refresh: true,
          cancelToken: cancel);
    } on DioError catch (e) {
      if (e.response == null) return '';
    }
    return response[response.keys.elementAt(0)]['data'];
  }

  Future<List<TituloModel>?>? pegarListagem(
      {bool refresh = false, CancelToken? cancel});
}
