import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

import '../controllers/auth_controller.dart';
import '../models/capitulo_episodio_model.dart';
import '../models/titulo_model.dart';

part 'firestore_controller.g.dart';

class FirestoreController = _FirestoreControllerBase with _$FirestoreController;

extension S on String {
  String format() {
    return this.replaceAll('.', '').replaceAll('/', '');
  }
}

abstract class _FirestoreControllerBase with Store {
  final Firestore _firestore = Firestore.instance;
  final AuthController _authController = Modular.get();

  CollectionReference _colecoes(String colecao) => _firestore
      .collection('usuarios')
      .document(_authController.userID)
      .collection(colecao);

  Future<void> copiarDadosNuvem({
    @required String colecao,
    @required TituloModel titulo,
    @required Box<TituloModel> box,
  }) async {
    assert(colecao != '');
    if (_authController.userID != null) {
      final Map<String, dynamic> documento =
          (await _colecoes(colecao).document(titulo.nomeFormatado).get())?.data;
      if (documento != null) {
        documento.forEach((String key, dynamic value) {
          if (titulo.lista.containsKey(key.format()))
            titulo.lista[key.format()].status = value;
          else {
            CapEpModel capEp = CapEpModel();
            capEp.titulo = key.format();
            capEp.status = value;
            titulo.lista[key.format()] = capEp;
          }
        });
      }
    }
  }

  Future<void> copiarDadosParaNuvem({
    @required String colecao,
    @required TituloModel titulo,
    @required Box<TituloModel> box,
  }) async {
    assert(colecao != '');
    if (_authController.userID != null) {
      final DocumentSnapshot documento =
          await _colecoes(colecao).document(titulo.nomeFormatado).get();
      for (CapEpModel value in titulo.lista.values) {
        await atualizarDados(
            colecao: colecao, titulo: titulo, value: value, doc: documento);
      }
    }
  }

  Future<void> atualizarDados({
    @required String colecao,
    @required TituloModel titulo,
    @required CapEpModel value,
    DocumentSnapshot doc,
  }) async {
    assert(colecao != '');
    if (_authController.userID != null) {
      final DocumentSnapshot documento =
          doc ?? await _colecoes(colecao).document(titulo.nomeFormatado).get();
      await _firestore.runTransaction((Transaction tx) async {
        if (documento.exists)
          await tx.update(
            documento.reference,
            {value.tituloFormatado: value.status},
          );
        else
          await tx.set(
            documento.reference,
            {value.tituloFormatado: value.status},
          );
      });
    }
  }
}
