import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/shared/controllers/auth_controller.dart';
import 'package:flutter_leitor/app/shared/interfaces/status.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'firestore_controller.g.dart';

class FirestoreController = _FirestoreControllerBase with _$FirestoreController;

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
          (await _colecoes(colecao).document(titulo.nome).get())?.data;
      if (documento != null) {
        documento.forEach((String key, dynamic value) {
          if (titulo.lista.containsKey(key))
            titulo.lista[key].status = value;
          else{
            IStatus iStatus = IStatus();
            iStatus.titulo = key;
            iStatus.status = value;
            titulo.lista[key] = iStatus;
          }
        });
        await box.put(titulo.nome, titulo);
      }
    }
  }

  void copiarDadosParaNuvem({
    @required String colecao,
    @required TituloModel titulo,
    @required Box<TituloModel> box,
  }) {
    assert(colecao != '');
    if (_authController.userID != null) {
      final DocumentReference documento =
          _colecoes(colecao).document(titulo.nome);
      _firestore.runTransaction((Transaction tx) async {
        titulo.lista.forEach((String key, IStatus value) async {
          await tx.set(
            documento,
            {key: value.status},
          );
        });
      });
    }
  }

  void atualizarDados({
    @required String colecao,
    @required TituloModel titulo,
    @required IStatus value,
  }) {
    final DocumentReference documento =
        _colecoes(colecao).document(titulo.nome);
    _firestore.runTransaction((Transaction tx) async {
      await tx.set(
        documento,
        {value.titulo: value.status},
      );
    });
  }
}
