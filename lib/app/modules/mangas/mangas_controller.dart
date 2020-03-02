import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

import '../../shared/controllers/listagem_principal.dart';
import '../../shared/models/titulo_model.dart';

part 'mangas_controller.g.dart';

class MangasController = _MangasBase with _$MangasController;

abstract class _MangasBase extends ListagemPrincipal with Store {
  _MangasBase() : super() {
    box = Hive.openBox<TituloModel>("mangas");
  }
}
