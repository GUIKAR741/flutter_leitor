import 'package:dio/dio.dart';
import 'package:flutter_leitor/app/shared/utils/requisicao_mixin.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

import '../../../shared/interfaces/repository_unique.dart';
import '../../../shared/models/capitulo_episodio_model.dart';
import '../../../shared/models/titulo_model.dart';

class HqRepository extends IRepositoryUnique with RequisicaoMixin {
  @override
  Future<List<CapEpModel>> listarTitulo(
    TituloModel hq, {
    bool refresh = false,
    CancelToken cancel,
  }) async {
    String data;
    try {
      data = await requisicaoErroDb(
        dio,
        hq.link,
        refresh: refresh,
        cancel: cancel,
      );
    } on DioError catch (e) {
      if (e.request == null) return [];
    }
    Document soup = parse(data);
    hq.descricao = soup
        .querySelectorAll('div.col-md-8>p')
        .last
        .text
        .replaceAll('Sinopse:', '')
        .trim();
    List<Element> td = soup.querySelectorAll("td");
    List<CapEpModel> capitulos = List();
    td.forEach(
      (data) {
        capitulos.add(CapEpModel(
            titulo: data.querySelector('a').text,
            link: data.querySelector('a').attributes['href']));
      },
    );
    return capitulos.reversed.toList();
  }

  Future<List<String>> imagens(
    String link, {
    bool refresh = false,
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
        .where((e) => (e.attributes['pag']?.isNotEmpty ?? false))
        .map((e) => e.attributes['src'])
        .toList();
  }

  @override
  void dispose() {}
}
