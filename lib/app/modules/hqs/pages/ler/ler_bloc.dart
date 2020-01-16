import 'package:flutter_leitor/app/modules/hqs/repositories/hq_repository.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/widgets/pagina_imagem/pagina_imagem_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class LerBloc extends Disposable {
  final HqRepository repo;
  final BehaviorSubject<List<PaginaImagemWidget>> _dados =
      BehaviorSubject<List<PaginaImagemWidget>>();
  final BehaviorSubject<String> _pagina = BehaviorSubject<String>();

  Capitulo capitulo;
  List<String> imagens;
  int index = 0;

  LerBloc(this.repo);

  Stream<List<PaginaImagemWidget>> get dados => _dados.stream;
  Stream<String> get pagina => _pagina.stream;

  void listarImagens() {
    _pagina.add(null);
    _dados.add(null);
    repo.imagens(capitulo.link).then((data) {
      index = 0;
      imagens = data;
      _pagina.add("${index + 1}/${imagens.length}");
      _dados.add(data.map((String i) => PaginaImagemWidget(url: i)).toList());
    });
  }

  void mudar(int pagina) {
    (pagina > index) ? proximo() : anterior();
  }

  void anterior() {
    if ((index--) - 1 >= 0) {
      _pagina.add("${index + 1}/${imagens.length}");
    }
  }

  proximo() {
    if ((index++) + 1 < imagens.length) {
      _pagina.add("${index + 1}/${imagens.length}");
    }
  }

  @override
  void dispose() {
    _dados.close();
    _pagina.close();
  }
}
