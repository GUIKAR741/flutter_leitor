import 'package:flutter_leitor/app/shared/models/titulo_model.dart';

abstract class RepositoryPrincipal {
  Future<String> verificaData();
  Future<List<TituloModel>> pegarListagem({bool refresh = false});
}
