import 'package:flutter/cupertino.dart';
import 'package:flutter_leitor/app/modules/hqs/repositories/hq_repository.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class HqBloc extends Disposable {
  final HqRepository repo;
  Titulo hq;
  List<Capitulo> capitulos = [];
  final BehaviorSubject<List<Capitulo>> dados =
      BehaviorSubject<List<Capitulo>>();
  bool _isReversed = false;
  final ScrollController scroll = ScrollController();

  HqBloc(this.repo);

  listarCapitulos() {
    dados.add(null);
    repo.capitulos(hq).then((data) {
      capitulos = data;
      dados.add(data);
    });
  }

  inverterCapitulos() {
    dados.add(null);
    repo.capitulos(hq).then((data) {
      dados.add(_isReversed ? data : data.reversed.toList());
      capitulos = data;
      _isReversed = !_isReversed;
    });
  }

  void pesquisar(res) {
    dados.add(null);
    List<Capitulo> pesquisa = capitulos
        .where((t) => t.titulo.toLowerCase().contains(res.toLowerCase()))
        .toList();
    dados.add(pesquisa.length > 0 ? pesquisa : capitulos);
  }

  @override
  void dispose() {
    scroll.dispose();
    dados.close();
  }
}
