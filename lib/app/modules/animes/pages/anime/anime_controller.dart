import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/animes/repositories/anime_repository.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_episodio_model.dart';
import 'package:flutter_leitor/app/shared/services/notification_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/controllers/listagem_titulo.dart';
import '../../../../shared/models/titulo_model.dart';

part 'anime_controller.g.dart';

class AnimeController = _AnimeBase with _$AnimeController;

abstract class _AnimeBase extends ListagemTitulo with Store {
  _AnimeBase() {
    box = Hive.openBox<TituloModel>("animes");
    colecao = "animes";
  }

  Future<void> videoExterno(CapEpModel ep) async {
    final String link = await (repo as AnimeRepository).linkVideo(
      ep,
      cancel: cancel,
    );
    if (link == "link_invalido") {
      Modular.get<NotificationService>().notificacaoPadrao(
        mensagem: "Capitulo Não Disponivel",
        tipo: NotificationType.danger,
        icon: Icon(Icons.error),
      );
      return;
    } else if (link == null || link.isEmpty) return;
    final AndroidIntent intent = AndroidIntent(
      action: "action_view",
      data: link,
      type: "video/*",
    );
    await intent.launch();
    addLista(ep.titulo, ep, add: true);
  }
}
