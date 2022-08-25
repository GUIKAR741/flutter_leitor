import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';

part 'ler_controle_controller.g.dart';

class LerControleController extends _LerControleBase
    with _$LerControleController {}

abstract class _LerControleBase with Store {
  @observable
  bool esconderControle = false;

  @action
  void mudar() {
    esconderControle = !esconderControle;
    if (esconderControle) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [],
      );
    } else {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
    }
  }
}
