import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/hqs/repositories/hq_repository.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/widgets/pagina_imagem/pagina_imagem_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:preload_page_view/preload_page_view.dart';

part 'ler_controller.g.dart';

class LerController extends _LerBase with _$LerController {
  LerController(HqRepository repo) : super(repo);

  @override
  void dispose() {}
}

abstract class _LerBase extends Disposable with Store {
  final HqRepository _repo;
  final PreloadPageController pageController = PreloadPageController();

  _LerBase(this._repo);

  CapituloModel _capitulo;
  int _index = 0;
  bool _paginacao = true;
  int _paginaIndex;
  List<PaginaImagemWidget> _imagens;

  @observable
  ObservableList<PaginaImagemWidget> imagens;
  @observable
  IconData icone;
  @observable
  String pagina = '';

  bool get paginacao => _paginacao;
  set capitulo(CapituloModel value) => _capitulo = value;

  @action
  void listarImagens() {
    icone = Icons.pause;
    pagina = '';
    imagens = null;
    _repo.imagens(_capitulo.link).then((data) {
      _index = 0;
      imagens = data
          .map((String i) => PaginaImagemWidget(url: i))
          .toList()
          .asObservable();
      pagina = "${_index + 1}/${imagens.length}";
    });
  }

  @action
  void pausar() {
    if (_paginacao) {
      pagina = "${_index + 1}/${imagens.length}";
      _imagens = imagens;
      imagens = [imagens[_index]].asObservable();
      icone = Icons.play_arrow;
    } else {
      imagens = _imagens;
      pageController.jumpToPage(_index);
      icone = Icons.pause;
    }
    _paginacao = !_paginacao;
  }

  @action
  void mudar(int pagina) {
    (pagina > _index) ? proximo() : anterior();
  }

  @action
  void escrever(String valor) {
    if (int.tryParse(valor) != null) _paginaIndex = int.parse(valor);
  }

  @action
  void irPara() {
    if (_paginaIndex >= 1 && _paginaIndex <= imagens.length) {
      pagina = "$_paginaIndex/${imagens.length}";
      _index = _paginaIndex;
      pageController.jumpToPage(_index - 1);
    }
    Modular.to.pop();
  }

  @action
  void anterior() {
    if ((_index--) - 1 >= 0) {
      pagina = "${_index + 1}/${imagens.length}";
    }
  }

  @action
  void proximo() {
    if ((_index++) + 1 < imagens.length) {
      pagina = "${_index + 1}/${imagens.length}";
    }
  }
}
