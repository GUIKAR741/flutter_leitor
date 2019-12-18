import 'package:flutter_leitor/app/modules/animes/animes_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AnimesModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AnimesBloc()),
      ];

  @override
  List<Router> get routers => [];

  static Inject get to => Inject<AnimesModule>.of();
}
