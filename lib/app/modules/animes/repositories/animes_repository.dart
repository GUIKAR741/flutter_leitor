import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';

class AnimesRepository extends Disposable {
  final Dio client;

  AnimesRepository(this.client);

  Future fetchPost() async {
    final response =
        await client.get("https://leitor-mangas-flutter.firebaseio.com/dados/animes.json");
    return response.data;
  }

  //dispose will be called automatically
  @override
  void dispose() {
    this.client.close();
  }
}
