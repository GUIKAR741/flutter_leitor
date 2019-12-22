import 'package:dio/dio.dart';
import 'package:flutter_leitor/app/shared/dio/custom_dio.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MangasRepository extends Disposable {
  final CustomDio dio;

  MangasRepository(this.dio);

  Future verificaData() async {
    final response = await dio.client.get(
        "https://leitor-mangas-flutter.firebaseio.com/dados/atualizacao.json");
    return response.data[response.data.keys.elementAt(0)]['data'];
  }

  Future pegarMangas(bool refresh) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> extra = {};
    if (prefs.containsKey('data_atualizacao')) {
      DateTime dataSalva = DateTime.parse(prefs.getString('data_atualizacao'));
      DateTime dataAtual = DateTime.now();
      extra['refresh'] = dataAtual.isBefore(dataSalva);
    } else {
      String data = await verificaData();
      prefs.setString('data_atualizacao', data);
      extra['refresh'] = true;
    }
    extra['refresh'] = refresh ? refresh : extra['refresh'];
    final response = await dio.client.get(
        "https://leitor-mangas-flutter.firebaseio.com/dados/mangas.json",
        options: Options(extra: extra));
    return Titulo.fromJsonList(response.data[response.data.keys.elementAt(0)]);
  }

  @override
  void dispose() {}
}
