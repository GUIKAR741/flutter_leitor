import 'package:flutter_leitor/app/modules/animes/animes_module.dart';
import 'package:flutter_leitor/app/modules/assistir/assistir_module.dart';
import 'package:flutter_leitor/app/modules/home/home_controller.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_module.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_leitor/app/modules/home/home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => HomePage()),
        Router('/mangas', module: MangasModule()),
        Router('/animes', module: AnimesModule()),
        Router('/assistir', module: AssistirModule()),
        Router('/hqs', module: HqsModule()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
