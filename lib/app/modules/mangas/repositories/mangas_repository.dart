import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';

class MangasRepository extends Disposable {
  final Dio client;

  MangasRepository(this.client);

  Future fetchPost() async {
    final response = await client.get('https://jsonplaceholder.typicode.com/posts/1');
    return response.data;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
