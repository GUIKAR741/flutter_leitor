import 'package:flutter_leitor/app/modules/mangas/repositories/manga_repository.dart';
import 'package:flutter_leitor/app/shared/controllers/listagem_titulo.dart';
// import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
// import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
// import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'manga_controller.g.dart';

class MangaController extends _MangaBase with _$MangaController {
  MangaController(MangaRepository repo) : super(repo);
}

abstract class _MangaBase extends ListagemTitulo with Store {
  // Future<Box<TituloModel>> _box;

  _MangaBase(MangaRepository repo) : super(repo) {
    // _box = Hive.openBox<TituloModel>("mangas");
  }

  @override
  void listarTitulo() async {
    super.listarTitulo();
    // Box box = (await _box);
    // lista.whenComplete(() {
    //   // if (!box.containsKey(titulo.nome)) {
    //   titulo.lista = HiveList(box);
    //   // try{
    //   for (int i = 0; i < lista.value.length; i++) {
    //     print(i);
    //     try{
    //     titulo.lista.add(lista.value[i]);
    //     }catch(e){
    //       print(e);
    //     }
    //   }
    //   // }
    //   // box.put(titulo.nome, titulo);
    //   // }
    // });
  }

  @override
  void dispose() async {
    super.dispose();
    // (await _box).close();
  }
}
