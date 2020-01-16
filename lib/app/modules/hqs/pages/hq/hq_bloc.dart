import 'package:flutter/cupertino.dart';
import 'package:flutter_leitor/app/modules/hqs/repositories/hq_repository.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class HqBloc extends Disposable {
  final HqRepository repo;
  final BehaviorSubject<List<Capitulo>> _dados =
      BehaviorSubject<List<Capitulo>>();
  final ScrollController scroll = ScrollController();

  Titulo hq;
  List<Capitulo> capitulos = [];
  bool _isReversed = false;

  HqBloc(this.repo);

  Stream<List<Capitulo>> get dados => _dados.stream;

  void listarCapitulos() {
    _dados.add(null);
    repo.capitulos(hq).then((data) {
      capitulos = data;
      _dados.add(data);
    });
  }

  void inverterCapitulos() {
    _dados.add(null);
    repo.capitulos(hq).then((data) {
      _dados.add(_isReversed ? data : data.reversed.toList());
      capitulos = data;
      _isReversed = !_isReversed;
    });
  }

  void pesquisar(res) {
    _dados.add(null);
    List<Capitulo> pesquisa = capitulos
        .where((t) => t.titulo.toLowerCase().contains(res.toLowerCase()))
        .toList();
    _dados.add(pesquisa.length > 0 ? pesquisa : capitulos);
  }

  @override
  void dispose() {
    scroll.dispose();
    _dados.close();
  }
}
