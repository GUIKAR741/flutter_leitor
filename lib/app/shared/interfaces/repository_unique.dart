import 'package:flutter_leitor/app/shared/models/titulo_model.dart';

abstract class IRepositoryUnique {
  Future<List> listarTitulo(TituloModel titulo);
}
