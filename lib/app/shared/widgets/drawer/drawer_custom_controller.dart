import 'package:flutter_leitor/app/shared/auth/auth_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'drawer_custom_controller.g.dart';

class DrawerCustomController = _DrawerBase with _$DrawerCustomController;

abstract class _DrawerBase with Store {
  final AuthController authController = Modular.get<AuthController>();

   @observable
  bool loading = false;

  @action
  Future loginWithGoogle() async {
    try {
      loading = true;
      await authController.loginWithGoogle();
      Modular.to.pushReplacementNamed('/home');
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
      Modular.to.pushReplacementNamed('/home');
    } catch (e) {
      loading = false;
    }
  }

  @observable
  bool esconderLogout = true;

  @action
  void mostrarLogout({bool value}) => esconderLogout = value ?? !esconderLogout;
}
