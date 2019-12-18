import 'package:flutter_leitor/app/modules/mangas/mangas_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MangasModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => MangasBloc()),
      ];

  @override
  List<Router> get routers => [];

  static Inject get to => Inject<MangasModule>.of();
}
