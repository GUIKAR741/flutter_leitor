import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_controller.g.dart';

class AppController = _AppBase with _$AppController;

abstract class _AppBase with Store {
  @observable
  bool tema = true;

  ObservableFuture<SharedPreferences> _prefs;

  @visibleForTesting
  set prefsTest(ObservableFuture<SharedPreferences> value) => _prefs = value;

  _AppBase() {
    _prefs = SharedPreferences.getInstance().asObservable();
    _prefs.whenComplete(() {
      tema = _prefs.value.getBool('dark') ?? true;
    });
  }

  @action
  mudarTema() {
    _prefs.value.setBool('dark', !(_prefs.value.getBool('dark') ?? true));
    tema = _prefs.value.getBool('dark');
  }
}
