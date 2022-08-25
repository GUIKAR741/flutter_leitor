import 'package:leitor/app/shared/controllers/listagem_principal.dart';
import 'package:leitor/app/shared/util/constants.dart';
import 'package:mobx/mobx.dart';

part 'mangas_store.g.dart';

class MangasStore extends _MangasStoreBase with _$MangasStore {}

abstract class _MangasStoreBase extends ListagemPrincipal with Store {
  _MangasStoreBase() : super(mangas);
}
