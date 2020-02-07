import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

class AppController extends _AppBase with _$AppController {
  @override
  Future<void> dispose() async {
    await (await _box).close();
    await Hive.close();
  }
}

abstract class _AppBase extends Disposable with Store {
  @observable
  bool tema = true;

  Future<Box<bool>> _box;

  @visibleForTesting
  Future<Box<bool>> get box => _box;

  _AppBase() {
    _box = Hive.openBox<bool>('theme');
    _box.whenComplete(() async {
      tema = (await _box).get('dark', defaultValue: true);
    });
  }

  @action
  mudarTema() async {
    Box<bool> box = await _box;
    box.put('dark', !tema);
    tema = box.get('dark');
  }
}
