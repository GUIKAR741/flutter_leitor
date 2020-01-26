import 'package:flutter_leitor/app/modules/hqs/repositories/hqs_repository.dart';
import 'package:flutter_leitor/app/shared/utils/listagem_principal.dart';
import 'package:mobx/mobx.dart';

part 'hqs_controller.g.dart';

class HqsController extends _HqsBase with _$HqsController {
  HqsController(HqsRepository repo) : super(repo);
}

abstract class _HqsBase extends ListagemPrincipal with Store {
  _HqsBase(HqsRepository repo) : super(repo);
}
