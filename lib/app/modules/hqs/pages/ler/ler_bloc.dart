import 'dart:async';

import 'package:flutter_leitor/app/modules/hqs/repositories/hq_repository.dart';
import 'package:flutter_leitor/app/modules/hqs/widgets/pagina_hq/pagina_hq_widget.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LerBloc extends Disposable {
  Capitulo capitulo;
  final HqRepository repo;
  List<String> imagens;
  int index = 0;
  final StreamController<List<PaginaHqWidget>> _dados =
      StreamController<List<PaginaHqWidget>>.broadcast();
  Stream<List<PaginaHqWidget>> get dados => _dados.stream;

  final StreamController<String> _pagina = StreamController<String>.broadcast();
  Stream<String> get pagina => _pagina.stream;

  LerBloc(this.repo);

  listarImagens() {
    repo.imagens(capitulo.link).then((data) {
      index = 0;
      imagens = data;
      _pagina.add("${index + 1}/${imagens.length}");
      _dados.add(data.map((String i) => PaginaHqWidget(url: i)).toList());
    });
  }

  mudar(int pagina) {
    if (pagina > index)
      proximo();
    else
      anterior();
  }

  anterior() {
    if (index - 1 >= 0) {
      --index;
      _pagina.add("${index + 1}/${imagens.length}");
    }
  }

  proximo() {
    if (index + 1 < imagens.length) {
      ++index;
      _pagina.add("${index + 1}/${imagens.length}");
    }
  }

  @override
  void dispose() {
    _dados.close();
    _pagina.close();
  }
}
