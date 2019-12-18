import 'package:flutter_leitor/app/modules/animes/animes_module.dart';
import 'package:flutter_leitor/app/modules/home/home_bloc.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_leitor/app/modules/home/home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeBloc()),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => HomePage()),
        Router('/mangas', module: MangasModule()),
        Router('/animes', module: AnimesModule()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
