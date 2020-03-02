import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/controllers/listagem_titulo.dart';
import '../../../../shared/models/capitulo_episodio_model.dart';
import '../../../../shared/models/titulo_model.dart';
import '../../../../shared/services/notification_service.dart';
import '../../repositories/anime_repository.dart';

part 'anime_controller.g.dart';

class AnimeController = _AnimeBase with _$AnimeController;

abstract class _AnimeBase extends ListagemTitulo with Store {
  _AnimeBase() {
    box = Hive.openBox<TituloModel>("animes");
    colecao = "animes";
  }

  Future<void> videoExterno(CapEpModel ep) async {
    addLista(ep.tituloFormatado, ep, add: true);
    final String link = await (repo as AnimeRepository).linkVideo(
      ep,
      cancel: cancel,
    );
    if (link == "link_invalido" || link == null || link.isEmpty) {
      Modular.get<NotificationService>().notificacaoPadrao(
        mensagem: "Capitulo Não Disponivel",
        tipo: NotificationType.danger,
        icon: Icon(Icons.error),
      );
      return;
    }
    final AndroidIntent intent = AndroidIntent(
      action: "action_view",
      data: link,
      type: "video/*",
    );
    await intent.launch();
  }
}
