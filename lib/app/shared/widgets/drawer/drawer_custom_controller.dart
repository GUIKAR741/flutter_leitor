import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor/app/shared/controllers/auth_controller.dart';
import 'package:mobx/mobx.dart';

part 'drawer_custom_controller.g.dart';

class DrawerCustomController extends _DrawerBase with _$DrawerCustomController {
}

abstract class _DrawerBase with Store {
  final AuthController authController = Modular.get();

  @observable
  bool loading = false;

  @action
  Future loginWithGoogle() async {
    try {
      loading = true;
      await authController.loginWithGoogle();
      loading = false;
    } catch (e) {
      loading = false;
    }
  }

  @action
  Future logout() async {
    try {
      loading = true;
      await authController.logout();
      loading = false;
    } catch (e) {
      loading = false;
    }
  }

  @observable
  bool esconderLogout = true;

  @action
  void mostrarLogout({bool? value}) =>
      esconderLogout = value ?? !esconderLogout;
}
