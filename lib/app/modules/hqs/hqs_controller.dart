import 'package:mobx/mobx.dart';

import '../../shared/controllers/listagem_principal.dart';

part 'hqs_controller.g.dart';

class HqsController = _HqsBase with _$HqsController;

abstract class _HqsBase extends ListagemPrincipal with Store {}
