import 'package:leitor/app/shared/controllers/listagem_principal.dart';
import 'package:leitor/app/shared/util/constants.dart';
import 'package:mobx/mobx.dart';

part 'hqs_store.g.dart';

class HqsStore extends _HqsStoreBase with _$HqsStore {}

abstract class _HqsStoreBase extends ListagemPrincipal with Store {
  _HqsStoreBase() : super(hqs);
}
