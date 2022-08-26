import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:leitor/app/shared/interfaces/repository_unique.dart';
import 'package:leitor/app/shared/models/capitulo_episodio_model.dart';
import 'package:leitor/app/shared/models/titulo_model.dart';
import 'package:leitor/app/shared/util/requisicao_mixin.dart';

class MangaRepository extends IRepositoryUnique with RequisicaoMixin {
  @override
  Future<List<CapEpModel>> listarTitulo(
    TituloModel titulo, {
    bool? refresh = false,
    CancelToken? cancel,
  }) async {
    String? data;
    try {
      data = await requisicaoErroDb(
        dio,
        titulo.link!,
        refresh: refresh,
        cancel: cancel,
      );
    } on DioError catch (e) {
      titulo.descricao = 'Erro ao Carregar';
      if (e.response == null) return [];
    }
    Document soup = parse(data);
    titulo.descricao =
        soup.querySelector('div.panel-body')!.text.trim().replaceAll('\n', '');
    List<Element> divs = soup.querySelectorAll("div.row.capitulos");
    List<CapEpModel> capitulos = [];
    for (var data in divs) {
      capitulos.add(CapEpModel(
          titulo: data
              .querySelector('a')!
              .text
              .replaceAll('Cap.', 'Cap')
              .replaceAll('.', ' '),
          link: data.querySelector('a')!.attributes['href'],
          info: data.querySelector('a')!.nextElementSibling!.innerHtml));
    }
    return capitulos.reversed.toList();
  }

  @override
  Future<List<String?>?> imagens(
    String link, {
    bool? refresh,
    CancelToken? cancel,
  }) async {
    String? data;
    try {
      data = await requisicaoErroDb(
        dio,
        link,
        refresh: refresh!,
        cancel: cancel,
      );
    } on DioError catch (e) {
      if (e.response == null) return [];
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
