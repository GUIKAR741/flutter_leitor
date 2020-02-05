import 'package:dio/dio.dart';
import 'package:flutter_leitor/app/shared/interfaces/repository_principal.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_leitor/app/shared/services/dio_service.dart';
import 'package:hive/hive.dart';

class AnimesRepository extends IRepositoryPrincipal {
  AnimesRepository(DioService dio) : super(dio);

  @override
  Future<List<TituloModel>> pegarListagem({bool refresh = false}) async {
    Box<String> boxData = await box;
    if (boxData.containsKey('data_atualizacao')) {
      DateTime dataSalva = DateTime.parse(boxData.get('data_atualizacao'));
      DateTime dataAtual = DateTime.now();
      if (dataAtual.isBefore(dataSalva)) {
        String data = await verificaData();
        boxData.put('data_atualizacao', data);
      }
      refresh = dataAtual.isBefore(dataSalva);
    } else {
      String data = await verificaData();
      boxData.put('data_atualizacao', data);
      refresh = true;
    }
    if (refresh) {
      String data = await verificaData();
      boxData.put('data_atualizacao', data);
    }
    dynamic response;
    try {
      response = await dio.getLink(
          "https://leitor-mangas-flutter.firebaseio.com/dados/animes.json",
          refresh: refresh,
          contextError: "Falha ao Listar Animes");
    } on DioError catch (_) {
      return [];
    }
    return TituloModel.fromJsonList(response[response.keys.elementAt(0)]);
  }
}
