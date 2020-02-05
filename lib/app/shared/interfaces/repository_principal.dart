import 'package:dio/dio.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_leitor/app/shared/services/dio_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class IRepositoryPrincipal extends Disposable {
  final DioService dio;

  IRepositoryPrincipal(this.dio);

  Future<String> verificaData() async {
    dynamic response;
    try {
      response = await dio.getLink(
          "https://leitor-mangas-flutter.firebaseio.com/dados/atualizacao.json",
          contextError: "Falha ao Pegar Data");
    } on DioError catch (e) {
      if (e.response == null) return '';
    }
    return response[response.keys.elementAt(0)]['data'];
  }

  Future<List<TituloModel>> pegarListagem({bool refresh = false});
}
