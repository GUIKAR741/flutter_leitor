// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ler.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Ler on _LerBase, Store {
  late final _$capituloAtom = Atom(name: '_LerBase.capitulo', context: context);

  @override
  CapEpModel? get capitulo {
    _$capituloAtom.reportRead();
    return super.capitulo;
  }

  @override
  set capitulo(CapEpModel? value) {
    _$capituloAtom.reportWrite(value, super.capitulo, () {
      super.capitulo = value;
    });
  }

  late final _$imagensAtom = Atom(name: '_LerBase.imagens', context: context);

  @override
  ObservableFuture<List<Widget>>? get imagens {
    _$imagensAtom.reportRead();
    return super.imagens;
  }

  @override
  set imagens(ObservableFuture<List<Widget>>? value) {
    _$imagensAtom.reportWrite(value, super.imagens, () {
      super.imagens = value;
    });
  }

  late final _$iconeAtom = Atom(name: '_LerBase.icone', context: context);

  @override
  IconData? get icone {
    _$iconeAtom.reportRead();
    return super.icone;
  }

  @override
  set icone(IconData? value) {
    _$iconeAtom.reportWrite(value, super.icone, () {
      super.icone = value;
    });
  }

  late final _$paginaAtom = Atom(name: '_LerBase.pagina', context: context);

  @override
  String? get pagina {
    _$paginaAtom.reportRead();
    return super.pagina;
  }

  @override
  set pagina(String? value) {
    _$paginaAtom.reportWrite(value, super.pagina, () {
      super.pagina = value;
    });
  }

  late final _$_LerBaseActionController =
      ActionController(name: '_LerBase', context: context);

  @override
  void pausar() {
    final _$actionInfo =
        _$_LerBaseActionController.startAction(name: '_LerBase.pausar');
    try {
      return super.pausar();
    } finally {
      _$_LerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void mudar(int pagina) {
    final _$actionInfo =
        _$_LerBaseActionController.startAction(name: '_LerBase.mudar');
    try {
      return super.mudar(pagina);
    } finally {
      _$_LerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void irPara(BuildContext context, String valor) {
    final _$actionInfo =
        _$_LerBaseActionController.startAction(name: '_LerBase.irPara');
    try {
      return super.irPara(context, valor);
    } finally {
      _$_LerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void anterior() {
    final _$actionInfo =
        _$_LerBaseActionController.startAction(name: '_LerBase.anterior');
    try {
      return super.anterior();
    } finally {
      _$_LerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void proximo() {
    final _$actionInfo =
        _$_LerBaseActionController.startAction(name: '_LerBase.proximo');
    try {
      return super.proximo();
    } finally {
      _$_LerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void listenerPage() {
    final _$actionInfo =
        _$_LerBaseActionController.startAction(name: '_LerBase.listenerPage');
    try {
      return super.listenerPage();
    } finally {
      _$_LerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
capitulo: ${capitulo},
imagens: ${imagens},
icone: ${icone},
pagina: ${pagina}
    ''';
  }
}
