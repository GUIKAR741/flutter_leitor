// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ler_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LerController on _LerBase, Store {
  final _$imagensAtom = Atom(name: '_LerBase.imagens');

  @override
  ObservableList<PaginaImagemWidget> get imagens {
    _$imagensAtom.context.enforceReadPolicy(_$imagensAtom);
    _$imagensAtom.reportObserved();
    return super.imagens;
  }

  @override
  set imagens(ObservableList<PaginaImagemWidget> value) {
    _$imagensAtom.context.conditionallyRunInAction(() {
      super.imagens = value;
      _$imagensAtom.reportChanged();
    }, _$imagensAtom, name: '${_$imagensAtom.name}_set');
  }

  final _$iconeAtom = Atom(name: '_LerBase.icone');

  @override
  IconData get icone {
    _$iconeAtom.context.enforceReadPolicy(_$iconeAtom);
    _$iconeAtom.reportObserved();
    return super.icone;
  }

  @override
  set icone(IconData value) {
    _$iconeAtom.context.conditionallyRunInAction(() {
      super.icone = value;
      _$iconeAtom.reportChanged();
    }, _$iconeAtom, name: '${_$iconeAtom.name}_set');
  }

  final _$paginaAtom = Atom(name: '_LerBase.pagina');

  @override
  String get pagina {
    _$paginaAtom.context.enforceReadPolicy(_$paginaAtom);
    _$paginaAtom.reportObserved();
    return super.pagina;
  }

  @override
  set pagina(String value) {
    _$paginaAtom.context.conditionallyRunInAction(() {
      super.pagina = value;
      _$paginaAtom.reportChanged();
    }, _$paginaAtom, name: '${_$paginaAtom.name}_set');
  }

  final _$_LerBaseActionController = ActionController(name: '_LerBase');

  @override
  void listarImagens() {
    final _$actionInfo = _$_LerBaseActionController.startAction();
    try {
      return super.listarImagens();
    } finally {
      _$_LerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pausar() {
    final _$actionInfo = _$_LerBaseActionController.startAction();
    try {
      return super.pausar();
    } finally {
      _$_LerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void mudar(int pagina) {
    final _$actionInfo = _$_LerBaseActionController.startAction();
    try {
      return super.mudar(pagina);
    } finally {
      _$_LerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void escrever(String valor) {
    final _$actionInfo = _$_LerBaseActionController.startAction();
    try {
      return super.escrever(valor);
    } finally {
      _$_LerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void irPara() {
    final _$actionInfo = _$_LerBaseActionController.startAction();
    try {
      return super.irPara();
    } finally {
      _$_LerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void anterior() {
    final _$actionInfo = _$_LerBaseActionController.startAction();
    try {
      return super.anterior();
    } finally {
      _$_LerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void proximo() {
    final _$actionInfo = _$_LerBaseActionController.startAction();
    try {
      return super.proximo();
    } finally {
      _$_LerBaseActionController.endAction(_$actionInfo);
    }
  }
}
