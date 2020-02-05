import 'package:dio/dio.dart';
import 'package:flutter_leitor/app/shared/interfaces/repository_principal.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_leitor/app/shared/services/dio_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MangasRepository extends IRepositoryPrincipal {
  MangasRepository(DioService dio) : super(dio);

  @override
  Future<List<TituloModel>> pegarListagem({bool refresh = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('data_atualizacao')) {
      DateTime dataSalva = DateTime.parse(prefs.getString('data_atualizacao'));
      DateTime dataAtual = DateTime.now();
      if (dataAtual.isBefore(dataSalva)) {
        String data = await verificaData();
        prefs.setString('data_atualizacao', data);
      }
      refresh = dataAtual.isBefore(dataSalva);
    } else {
      String data = await verificaData();
      prefs.setString('data_atualizacao', data);
      refresh = true;
    }
    if (refresh) {
      String data = await verificaData();
      prefs.setString('data_atualizacao', data);
    }
    dynamic response;
    try {
      response = await dio.getLink(
        "https://leitor-mangas-flutter.firebaseio.com/dados/mangas.json",
        refresh: refresh,
        contextError: "Falha ao Listar Mangas",
      );
    } on DioError catch (_) {
      return [];
    }
    return TituloModel.fromJsonList(
      response[response.keys.elementAt(0)],
    );
  }

  @override
  void dispose() {}
}
