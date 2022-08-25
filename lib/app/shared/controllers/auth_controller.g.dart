// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthController on _AuthBase, Store {
  Computed<AuthStatus>? _$statusComputed;

  @override
  AuthStatus get status => (_$statusComputed ??=
          Computed<AuthStatus>(() => super.status, name: '_AuthBase.status'))
      .value;
  Computed<String?>? _$userIDComputed;

  @override
  String? get userID => (_$userIDComputed ??=
          Computed<String?>(() => super.userID, name: '_AuthBase.userID'))
      .value;

  late final _$userAtom = Atom(name: '_AuthBase.user', context: context);

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$loginWithGoogleAsyncAction =
      AsyncAction('_AuthBase.loginWithGoogle', context: context);

  @override
  Future<dynamic> loginWithGoogle() {
    return _$loginWithGoogleAsyncAction.run(() => super.loginWithGoogle());
  }

  late final _$logoutAsyncAction =
      AsyncAction('_AuthBase.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$_AuthBaseActionController =
      ActionController(name: '_AuthBase', context: context);

  @override
  dynamic setUser(User? value) {
    final _$actionInfo =
        _$_AuthBaseActionController.startAction(name: '_AuthBase.setUser');
    try {
      return super.setUser(value);
    } finally {
      _$_AuthBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _initUser() {
    final _$actionInfo =
        _$_AuthBaseActionController.startAction(name: '_AuthBase._initUser');
    try {
      return super._initUser();
    } finally {
      _$_AuthBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
status: ${status},
userID: ${userID}
    ''';
  }
}
