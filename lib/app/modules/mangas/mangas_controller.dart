import 'package:flutter_leitor/app/shared/controllers/listagem_principal.dart';
import 'package:mobx/mobx.dart';

part 'mangas_controller.g.dart';

class MangasController = _MangasBase with _$MangasController;

abstract class _MangasBase extends ListagemPrincipal with Store {}
