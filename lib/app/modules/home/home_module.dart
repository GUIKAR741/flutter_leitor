import 'package:flutter_leitor/app/modules/home/home_controller.dart';
import 'package:flutter_leitor/app/modules/home/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind<HomeController>((i) => HomeController()),
      ];

  @override
  List<Router> get routers => [
        Router(
          '/',
          child: (_, args) => HomePage(),
        ),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
