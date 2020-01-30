import 'package:flutter_leitor/app/modules/animes/repositories/animes_repository.dart';
import 'package:flutter_leitor/app/shared/controllers/listagem_principal.dart';
import 'package:mobx/mobx.dart';

part 'animes_controller.g.dart';

class AnimesController extends _AnimesBase with _$AnimesController {
  AnimesController(AnimesRepository repo) : super(repo);
}

abstract class _AnimesBase extends ListagemPrincipal with Store {
  _AnimesBase(AnimesRepository repo) : super(repo);
}
