import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

import '../../shared/controllers/listagem_principal.dart';
import '../../shared/models/titulo_model.dart';

part 'animes_controller.g.dart';

class AnimesController = _AnimesBase with _$AnimesController;

abstract class _AnimesBase extends ListagemPrincipal with Store {
  _AnimesBase() : super() {
    box = Hive.openBox<TituloModel>("animes");
  }
}
