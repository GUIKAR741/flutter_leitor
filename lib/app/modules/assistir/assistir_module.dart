import 'package:flutter_leitor/app/modules/animes/repositories/anime_repository.dart';
import 'package:flutter_leitor/app/modules/assistir/assistir_bloc.dart';
import 'package:flutter_leitor/app/shared/dio/custom_dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_leitor/app/modules/assistir/assistir_page.dart';

class AssistirModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AssistirBloc(i.get<AnimeRepository>())),
        Bind((i) => AnimeRepository(Modular.get<CustomDio>())),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => AssistirPage(episodio: args.data)),
      ];

  static Inject get to => Inject<AssistirModule>.of();
}
