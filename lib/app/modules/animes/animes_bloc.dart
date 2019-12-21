import 'package:flutter_leitor/app/modules/animes/repositories/animes_repository.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class AnimesBloc extends Disposable {
  final AnimesRepository repo;
  
  BehaviorSubject<List<Titulo>> dados = BehaviorSubject<List<Titulo>>();

  AnimesBloc(this.repo){
    this.repo.pegarAnimes().then((mangas){
      this.dados.add(mangas);
    });
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    dados.close();
  }
}
