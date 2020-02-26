import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/shared/controllers/auth_controller.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_episodio_model.dart';
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
      final Map<String, dynamic> documento = (await _colecoes(colecao)
              .document(titulo.nome.replaceAll('.', ''))
              .get())
          ?.data;
      if (documento != null) {
        documento.forEach((String key, dynamic value) {
          if (titulo.lista.containsKey(key.replaceAll('.', '')))
            titulo.lista[key.replaceAll('.', '')].status = value;
          else {
            CapEpModel capEp = CapEpModel();
            capEp.titulo = key.replaceAll('.', '');
            capEp.status = value;
            titulo.lista[key.replaceAll('.', '')] = capEp;
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
      final DocumentSnapshot documento = await _colecoes(colecao)
          .document(titulo.nome.replaceAll('.', ''))
          .get();
      for (CapEpModel value in titulo.lista.values) {
        await atualizarDados(
          colecao: colecao,
          titulo: titulo,
          value: value,
          doc: documento
        );
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
      final DocumentSnapshot documento = doc ?? await _colecoes(colecao)
          .document(titulo.nome.replaceAll('.', ''))
          .get();
      await _firestore.runTransaction((Transaction tx) async {
        if (documento.exists)
          await tx.update(
            documento.reference,
            {value.titulo.replaceAll('.', ''): value.status},
          );
        else
          await tx.set(
            documento.reference,
            {value.titulo.replaceAll('.', ''): value.status},
          );
      });
    }
  }
}
