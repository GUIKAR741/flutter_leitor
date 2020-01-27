import 'package:flutter_leitor/app/shared/models/titulo_model.dart';

abstract class RepositoryUnique {
  Future<List> listarTitulo(TituloModel titulo);
}
