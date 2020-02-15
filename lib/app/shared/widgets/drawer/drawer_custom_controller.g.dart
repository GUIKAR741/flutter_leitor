// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drawer_custom_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DrawerCustomController on _DrawerBase, Store {
  final _$loadingAtom = Atom(name: '_DrawerBase.loading');

  @override
  bool get loading {
    _$loadingAtom.context.enforceReadPolicy(_$loadingAtom);
    _$loadingAtom.reportObserved();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.context.conditionallyRunInAction(() {
      super.loading = value;
      _$loadingAtom.reportChanged();
    }, _$loadingAtom, name: '${_$loadingAtom.name}_set');
  }

  final _$esconderLogoutAtom = Atom(name: '_DrawerBase.esconderLogout');

  @override
  bool get esconderLogout {
    _$esconderLogoutAtom.context.enforceReadPolicy(_$esconderLogoutAtom);
    _$esconderLogoutAtom.reportObserved();
    return super.esconderLogout;
  }

  @override
  set esconderLogout(bool value) {
    _$esconderLogoutAtom.context.conditionallyRunInAction(() {
      super.esconderLogout = value;
      _$esconderLogoutAtom.reportChanged();
    }, _$esconderLogoutAtom, name: '${_$esconderLogoutAtom.name}_set');
  }

  final _$loginWithGoogleAsyncAction = AsyncAction('loginWithGoogle');

  @override
  Future<dynamic> loginWithGoogle() {
    return _$loginWithGoogleAsyncAction.run(() => super.loginWithGoogle());
  }

  final _$logoutAsyncAction = AsyncAction('logout');

  @override
  Future<dynamic> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$_DrawerBaseActionController = ActionController(name: '_DrawerBase');

  @override
  void mostrarLogout({bool value}) {
    final _$actionInfo = _$_DrawerBaseActionController.startAction();
    try {
      return super.mostrarLogout(value: value);
    } finally {
      _$_DrawerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'loading: ${loading.toString()},esconderLogout: ${esconderLogout.toString()}';
    return '{$string}';
  }
}
