import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_leitor/app/shared/interfaces/auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'auth_controller.g.dart';

class AuthController = _AuthBase with _$AuthController;

abstract class _AuthBase with Store {
  final IAuthRepository _authRepository = Modular.get<IAuthRepository>();

  @computed
  AuthStatus get status => user == null ? AuthStatus.logoff : AuthStatus.logged;

  @observable
  FirebaseUser user;

  @action
  setUser(FirebaseUser value) => user = value;

  @action
  void _initUser() {
    _authRepository.getUser().then(setUser).catchError((e) {
      print(e);
    });
  }

  _AuthBase() {
    _initUser();
  }

  @action
  Future loginWithGoogle() async {
    user = await _authRepository.getLogin();
  }

  @action
  Future<void> logout() async {
    await _authRepository.getLogout();
    _initUser();
  }
}

enum AuthStatus { logged, logoff }