import 'package:leitor/app/shared/controllers/listagem_titulo.dart';
import 'package:leitor/app/shared/util/constants.dart';
import 'package:mobx/mobx.dart';

part 'hq_store.g.dart';

class HqStore extends _HqStoreBase with _$HqStore {}

abstract class _HqStoreBase extends ListagemTitulo with Store {
  _HqStoreBase() : super(hqs, hqs);
}
