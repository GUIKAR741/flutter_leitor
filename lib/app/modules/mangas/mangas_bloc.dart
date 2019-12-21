import 'package:flutter_leitor/app/modules/mangas/repositories/mangas_repository.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class MangasBloc extends Disposable {
  final MangasRepository repo;
  
  BehaviorSubject<List<Titulo>> dados = BehaviorSubject<List<Titulo>>();

  MangasBloc(this.repo){
    this.repo.pegarMangas().then((mangas){
      this.dados.add(mangas);
    });
  }


  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    dados.close();
  }
}
