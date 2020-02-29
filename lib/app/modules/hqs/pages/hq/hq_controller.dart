import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/controllers/listagem_titulo.dart';
import '../../../../shared/models/titulo_model.dart';

part 'hq_controller.g.dart';

class HqController extends _HqBase with _$HqController {}

abstract class _HqBase extends ListagemTitulo with Store {
  _HqBase() {
    box = Hive.openBox<TituloModel>("hqs");
    colecao = "hqs";
  }
}
