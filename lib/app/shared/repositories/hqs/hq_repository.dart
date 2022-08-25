import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:leitor/app/shared/interfaces/repository_unique.dart';
import 'package:leitor/app/shared/models/capitulo_episodio_model.dart';
import 'package:leitor/app/shared/models/titulo_model.dart';
import 'package:leitor/app/shared/util/requisicao_mixin.dart';

class HqRepository extends IRepositoryUnique with RequisicaoMixin {
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
      if (e.response == null) return [];
    }
    Document soup = parse(data);
    titulo.descricao = soup
        .querySelectorAll('div.col-md-8>p')
        .last
        .text
        .replaceAll('Sinopse:', '')
        .trim();
    List<Element> td = soup.querySelectorAll("td");
    List<CapEpModel> capitulos = [];
    for (var data in td) {
      capitulos.add(CapEpModel(
          titulo: data.querySelector('a')!.text.replaceAll('.', ' '),
          link: data.querySelector('a')!.attributes['href']));
    }
    return capitulos.reversed.toList();
  }

  @override
  Future<List<String?>?> imagens(
    String link, {
    bool? refresh = false,
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
        .where((e) => (e.attributes['pag']?.isNotEmpty ?? false))
        .map((e) => e.attributes['src'])
        .toList();
  }

  @override
  void dispose() {}
}
