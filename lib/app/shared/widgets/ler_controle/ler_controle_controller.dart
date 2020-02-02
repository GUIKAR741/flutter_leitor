import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';

part 'ler_controle_controller.g.dart';

class LerControleController = _LerControleBase with _$LerControleController;

abstract class _LerControleBase with Store {
  @observable
  bool mostrarControle = false;

  @action
  void mudar() {
    mostrarControle = !mostrarControle;
    if (mostrarControle)
      SystemChrome.setEnabledSystemUIOverlays([]);
    else
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }
}
