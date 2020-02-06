import 'package:flutter_leitor/app/modules/assistir/assistir_controller.dart';
import 'package:flutter_leitor/app/modules/assistir/assistir_page.dart';
import 'package:flutter_leitor/app/modules/assistir/repositories/assistir_anime_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AssistirModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind<AssistirController>((i) => AssistirController()),
        Bind<AssistirAnimeRepository>((i) => AssistirAnimeRepository()),
      ];

  @override
  List<Router> get routers => [
        Router(
          '/',
          child: (_, args) => AssistirPage(
            episodio: args.data,
          ),
        ),
      ];

  static Inject get to => Inject<AssistirModule>.of();
}
