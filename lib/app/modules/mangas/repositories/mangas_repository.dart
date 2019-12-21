import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';

class MangasRepository extends Disposable {
  final Dio client;

  MangasRepository(this.client);

  Future pegarMangas() async {
    final response = await client.get("https://leitor-mangas-flutter.firebaseio.com/dados/mangas.json");
    return Titulo.fromJsonList(response.data[response.data.keys.elementAt(0)]);
  }

  //dispose will be called automatically
  @override
  void dispose() {
    this.client.close();
  }
}
