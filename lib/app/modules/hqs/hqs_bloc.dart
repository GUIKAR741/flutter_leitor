import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/hqs/repositories/hqs_repository.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class HqsBloc extends Disposable {
  final HqsRepository repo;
  final BehaviorSubject<List<Titulo>> _dados = BehaviorSubject<List<Titulo>>();
  final ScrollController scroll = ScrollController();

  List<Titulo> titulos = [];

  HqsBloc(this.repo) {
    listar();
  }

  Stream<List<Titulo>> get dados => _dados.stream;

  void listar({bool refresh = false}) {
    this._dados.add(null);
    this.repo.pegarHQS(refresh).then((hqs) {
      titulos = hqs;
      this._dados.add(hqs);
    });
  }

  void pesquisar(res) {
    List<Titulo> pesquisa = titulos
        .where((t) => t.nome.toLowerCase().contains(res.toLowerCase()))
        .toList();
    _dados.add(pesquisa.length > 0 ? pesquisa : titulos);
  }

  @override
  void dispose() {
    scroll.dispose();
    _dados.close();
  }
}
