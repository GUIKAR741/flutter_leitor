import 'package:mobx/mobx.dart';

import '../../shared/controllers/listagem_principal.dart';

part 'mangas_controller.g.dart';

class MangasController = _MangasBase with _$MangasController;

abstract class _MangasBase extends ListagemPrincipal with Store {}
