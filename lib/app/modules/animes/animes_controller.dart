import '../../shared/controllers/listagem_principal.dart';
import 'package:mobx/mobx.dart';

part 'animes_controller.g.dart';

class AnimesController = _AnimesBase with _$AnimesController;

abstract class _AnimesBase extends ListagemPrincipal with Store {}
