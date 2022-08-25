import 'package:hive/hive.dart';
import 'package:leitor/app/shared/util/constants.dart';
import 'package:mobx/mobx.dart';

part 'theme_store.g.dart';

class ThemeStore extends _ThemeStoreBase with _$ThemeStore {}

abstract class _ThemeStoreBase with Store {
  @observable
  bool temaValue = false;

  @observable
  Box<bool>? temaBox;

  _ThemeStoreBase() {
    fetch();
    temaValue = temaBox!.get(dark, defaultValue: false)!;
  }

  void fetch() async {
    if (!Hive.isBoxOpen(tema)) {
      await Hive.openBox<bool>(tema);
    }
    temaBox = Hive.box<bool>(tema);
  }

  @action
  mudarTema() async {
    if (!Hive.isBoxOpen(tema)) {
      await Hive.openBox<bool>(tema);
      temaBox = Hive.box<bool>(tema);
    }
    temaBox!.put('dark', !(temaBox!.get(dark, defaultValue: false)!));
    temaValue = temaBox!.get(dark, defaultValue: false)!;
  }
}
