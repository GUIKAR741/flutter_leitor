import 'package:flutter_leitor/app/shared/controllers/listagem_principal.dart';
import 'package:mobx/mobx.dart';

part 'hqs_controller.g.dart';

class HqsController = _HqsBase with _$HqsController;

abstract class _HqsBase extends ListagemPrincipal with Store {}
