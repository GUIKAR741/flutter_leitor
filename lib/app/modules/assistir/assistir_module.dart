import 'package:flutter_leitor/app/modules/assistir/repositories/assistir_anime_repository.dart';
import 'package:flutter_leitor/app/modules/assistir/assistir_controller.dart';
import 'package:flutter_leitor/app/shared/services/dio_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_leitor/app/modules/assistir/assistir_page.dart';

class AssistirModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AssistirController(i.get<AssistirAnimeRepository>())),
        Bind((i) => AssistirAnimeRepository(Modular.get<DioService>())),
      ];

  @override
  List<Router> get routers => [
        Router('/',
            child: (_, args) => AssistirPage(
                  episodio: args.data,
                )),
      ];

  static Inject get to => Inject<AssistirModule>.of();
}
