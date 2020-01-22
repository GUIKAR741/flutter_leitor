import 'package:flutter_leitor/app/shared/dio/dio_service.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnimesRepository extends Disposable {
  final DioService dio;

  AnimesRepository(this.dio);

  Future<String> verificaData() async {
    final response = await dio.client.get(
        "https://leitor-mangas-flutter.firebaseio.com/dados/atualizacao.json");
    return response.data[response.data.keys.elementAt(0)]['data'];
  }

  Future<List<TituloModel>> pegarAnimes(bool refresh) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> extra = {};
    if (prefs.containsKey('data_atualizacao')) {
      DateTime dataSalva = DateTime.parse(prefs.getString('data_atualizacao'));
      DateTime dataAtual = DateTime.now();
      if (dataAtual.isBefore(dataSalva)) {
        String data = await verificaData();
        prefs.setString('data_atualizacao', data);
      }
      extra['refresh'] = dataAtual.isBefore(dataSalva);
    } else {
      String data = await verificaData();
      prefs.setString('data_atualizacao', data);
      extra['refresh'] = true;
    }
    if (refresh) {
      String data = await verificaData();
      prefs.setString('data_atualizacao', data);
      extra['refresh'] = refresh;
    }
    final response = await dio.client.get(
        "https://leitor-mangas-flutter.firebaseio.com/dados/animes.json",
        options: Options(extra: extra));
    return TituloModel.fromJsonList(
        response.data[response.data.keys.elementAt(0)]);
  }

  @override
  void dispose() {}
}
