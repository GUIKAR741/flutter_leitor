import 'package:dio/dio.dart';
import 'package:flutter_leitor/app/shared/utils/requisicao_mixin.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

import '../../../shared/interfaces/repository_unique.dart';
import '../../../shared/models/capitulo_episodio_model.dart';
import '../../../shared/models/titulo_model.dart';

class MangaRepository extends IRepositoryUnique with RequisicaoMixin {
  @override
  Future<List<CapEpModel>> listarTitulo(
    TituloModel manga, {
    bool refresh = false,
    CancelToken cancel,
  }) async {
    String data;
    try {
      data = await requisicaoErroDb(
        dio,
        manga.link,
        refresh: refresh,
        cancel: cancel,
      );
    } on DioError catch (e) {
      manga.descricao = 'Erro ao Carregar';
      if (e.request == null) return [];
    }
    Document soup = parse(data);
    manga.descricao =
        soup.querySelector('div.panel-body').text.trim().replaceAll('\n', '');
    List<Element> divs = soup.querySelectorAll("div.row.lancamento-linha");
    List<CapEpModel> capitulos = List();
    divs.forEach((data) {
      capitulos.add(CapEpModel(
          titulo: data.querySelector('a').text,
          link: data.querySelector('a').attributes['href'],
          info: data.querySelector('a').nextElementSibling.innerHtml));
    });
    return capitulos.reversed.toList();
  }

  Future<List<String>> imagens(
    String link, {
    bool refresh,
    CancelToken cancel,
  }) async {
    String data;
    try {
      data = await requisicaoErroDb(
        dio,
        link,
        refresh: refresh,
        cancel: cancel,
      );
    } on DioError catch (e) {
      if (e.request == null) return [];
    }
    Document soup = parse(data);
    return soup
        .querySelectorAll('img')
        .where((e) =>
            (e.attributes['pag']?.isNotEmpty ?? false) &&
            e.attributes['src'].toString().contains('/leitor/'))
        .map((e) => e.attributes['src'])
        .toList();
  }

  @override
  void dispose() {}
}
