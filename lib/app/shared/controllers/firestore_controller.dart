import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

import '../controllers/auth_controller.dart';
import '../models/capitulo_episodio_model.dart';
import '../models/titulo_model.dart';

part 'firestore_controller.g.dart';

class FirestoreController extends _FirestoreControllerBase
    with _$FirestoreController {}

extension S on String {
  String format() {
    return replaceAll('.', '').replaceAll('/', '');
  }
}

abstract class _FirestoreControllerBase with Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthController _authController = Modular.get();

  CollectionReference _colecoes(String colecao) => _firestore
      .collection('usuarios')
      .doc(_authController.userID)
      .collection(colecao);

  Future<void> copiarDadosNuvem({
    required String colecao,
    required TituloModel titulo,
    required Box<TituloModel> box,
  }) async {
    assert(colecao != '');
    final Map<String, dynamic>? documento =
        (await _colecoes(colecao).doc(titulo.nomeFormatado).get()).data()
            as Map<String, dynamic>?;
    documento?.forEach((String key, dynamic value) {
      if (titulo.lista != null) {
        if (titulo.lista!.containsKey(key.format())) {
          titulo.lista![key.format()]!.status = value;
        } else {
          CapEpModel capEp = CapEpModel();
          capEp.titulo = key.format();
          capEp.status = value;
          titulo.lista![key.format()] = capEp;
        }
      }
    });
  }

  Future<void> copiarDadosParaNuvem({
    required String colecao,
    required TituloModel titulo,
    required Box<TituloModel> box,
  }) async {
    assert(colecao != '');
    if (_authController.userID != null) {
      final DocumentReference documento =
          _colecoes(colecao).doc(titulo.nomeFormatado);
      if (titulo.lista != null) {
        for (CapEpModel value in titulo.lista!.values) {
          await atualizarDados(
            colecao: colecao,
            titulo: titulo,
            value: value,
            doc: documento,
          );
        }
      }
    }
  }

  Future<void> atualizarDados({
    required String colecao,
    required TituloModel titulo,
    required CapEpModel value,
    DocumentReference? doc,
  }) async {
    assert(colecao != '');
    if (_authController.userID != null) {
      final DocumentReference documentoRef =
          doc ?? _colecoes(colecao).doc(titulo.nomeFormatado);
      await _firestore.runTransaction((Transaction tx) async {
        final documento = await documentoRef.get();
        Map<String, dynamic> data =
            Map<String, dynamic>.from({value.tituloFormatado: value.status});
        if (documento.exists) {
          tx.update(
            documento.reference,
            data,
          );
        } else {
          tx.set(
            documento.reference,
            data,
          );
        }
      });
    }
  }
}
