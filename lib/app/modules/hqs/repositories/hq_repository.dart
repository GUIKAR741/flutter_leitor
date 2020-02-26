import 'package:dio/dio.dart';
import 'package:flutter_leitor/app/shared/interfaces/repository_unique.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_episodio_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class HqRepository extends IRepositoryUnique {
  Future<String> _requisicaoErroDb(String link, {CancelToken cancel}) async {
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
  Future<List<CapEpModel>> listarTitulo(TituloModel hq,
      {CancelToken cancel}) async {
    String data;
    try {
      data = await _requisicaoErroDb(
        hq.link,
        cancel: cancel,
      );
      // data = await dio.getLink(
      //   hq.link,
      //   contextError: "Falha ao Listar Titulo",
      //   refresh: true,
      // );
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
    return capitulos;
  }

  Future<List<String>> imagens(String link, {CancelToken cancel}) async {
    String data;
    try {
      data = await _requisicaoErroDb(
        link,
        cancel: cancel,
      );
      // data = await dio.getLink(
      //   link,
      //   contextError: "Falha ao Pegar Imagens",
      //   refresh: true,
      // );
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
