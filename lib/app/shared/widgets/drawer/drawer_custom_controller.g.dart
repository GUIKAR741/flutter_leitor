// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drawer_custom_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DrawerCustomController on _DrawerBase, Store {
  late final _$loadingAtom =
      Atom(name: '_DrawerBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$esconderLogoutAtom =
      Atom(name: '_DrawerBase.esconderLogout', context: context);

  @override
  bool get esconderLogout {
    _$esconderLogoutAtom.reportRead();
    return super.esconderLogout;
  }

  @override
  set esconderLogout(bool value) {
    _$esconderLogoutAtom.reportWrite(value, super.esconderLogout, () {
      super.esconderLogout = value;
    });
  }

  late final _$loginWithGoogleAsyncAction =
      AsyncAction('_DrawerBase.loginWithGoogle', context: context);

  @override
  Future<dynamic> loginWithGoogle() {
    return _$loginWithGoogleAsyncAction.run(() => super.loginWithGoogle());
  }

  late final _$logoutAsyncAction =
      AsyncAction('_DrawerBase.logout', context: context);

  @override
  Future<dynamic> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$_DrawerBaseActionController =
      ActionController(name: '_DrawerBase', context: context);

  @override
  void mostrarLogout({bool? value}) {
    final _$actionInfo = _$_DrawerBaseActionController.startAction(
        name: '_DrawerBase.mostrarLogout');
    try {
      return super.mostrarLogout(value: value);
    } finally {
      _$_DrawerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
esconderLogout: ${esconderLogout}
    ''';
  }
}
