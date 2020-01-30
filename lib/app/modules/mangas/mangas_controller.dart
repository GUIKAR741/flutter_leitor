import 'package:flutter_leitor/app/modules/mangas/repositories/mangas_repository.dart';
import 'package:flutter_leitor/app/shared/controllers/listagem_principal.dart';
import 'package:mobx/mobx.dart';

part 'mangas_controller.g.dart';

class MangasController extends _MangasBase with _$MangasController {
  MangasController(MangasRepository repo) : super(repo);
}

abstract class _MangasBase extends ListagemPrincipal with Store {
  _MangasBase(MangasRepository repo) : super(repo);
}
