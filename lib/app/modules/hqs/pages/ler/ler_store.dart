import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor/app/shared/models/capitulo_episodio_model.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/controllers/ler.dart';
import '../../../../shared/controllers/listagem_titulo.dart';
import '../../../../shared/interfaces/repository_unique.dart';
import '../../../../shared/widgets/pagina_imagem/pagina_imagem_widget.dart';

part 'ler_store.g.dart';

class LerStore extends _LerBase with _$LerStore{
  LerStore(ListagemTitulo controller, CapEpModel capitulo) : super(controller, capitulo);
}

abstract class _LerBase extends Ler with Store {
  final IRepositoryUnique _repo = Modular.get();

  _LerBase(ListagemTitulo controller, CapEpModel capitulo) : super(controller, capitulo);

  @override
  @action
  void listarImagens({bool refresh = false}) {
    icone = Icons.pause;
    pagina = '';
    imagens = null;
    paginacao = true;
    imagens = _repo
        .imagens(
      capitulo!.link!,
      refresh: refresh,
      cancel: cancel,
    )
        .then(
      (data) {
        index = data!.isNotEmpty ? 0 : -1;
        pagina = "${index + 1}/${data.length}";
        if (index == -1) {
          return [
            Center(
              child: ElevatedButton(
                child: const Text("Recarregar Imagens"),
                onPressed: () => listarImagens(refresh: true),
              ),
            )
          ];
        }
        return data.map((String? i) => PaginaImagemWidget(url: i!)).toList();
      },
    ).asObservable();
  }
}
