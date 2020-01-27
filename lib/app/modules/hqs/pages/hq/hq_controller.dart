import 'package:flutter_leitor/app/modules/hqs/repositories/hq_repository.dart';
import 'package:flutter_leitor/app/shared/utils/listagem_titulo.dart';
import 'package:mobx/mobx.dart';

part 'hq_controller.g.dart';

class HqController extends _HqBase with _$HqController {
  HqController(HqRepository repo) : super(repo);
}

abstract class _HqBase extends ListagemTitulo with Store {
  _HqBase(HqRepository repo) : super(repo);
}
