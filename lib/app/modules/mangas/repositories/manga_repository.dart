import 'package:dio/dio.dart';
import 'package:flutter_leitor/app/shared/interfaces/repository_unique.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_episodio_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class MangaRepository extends IRepositoryUnique {
  Future<String> _requisicaoErroDb(
    String link, {
    CancelToken cancel,
  }) async {
    String data;
    try {
      data = await dio.getLink(
        link,
        refresh: true,
        cancelToken: cancel,
        contextError: "Falha ao Listar Titulos",
      );
      if (!data.contains("Erro ao conectar ao banco de dados")) return data;
      return _requisicaoErroDb(link);
    } catch (e) {
      if (e.runtimeType == DioError && e.request != null) throw e;
      return _requisicaoErroDb(link);
    }
  }

  @override
  Future<List<CapEpModel>> listarTitulo(
    TituloModel manga, {
    CancelToken cancel,
  }) async {
    String data;
    try {
      data = await _requisicaoErroDb(
        manga.link,
        cancel: cancel,
      );
      // data = await dio.getLink(
      //   manga.link,
      //   refresh: true,
      //   contextError: "Falha ao Listar Titulos",
      // );
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
    return capitulos;
  }

  Future<List<String>> imagens(
    String link, {
    CancelToken cancel,
  }) async {
    String data;
    try {
      data = await _requisicaoErroDb(
        link,
        cancel: cancel,
      );
      // data = await dio.getLink(
      //   link,
      //   refresh: true,
      //   contextError: "Falha ao Pegar Imagens",
      // );
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
