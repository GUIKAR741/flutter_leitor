import 'package:flutter_leitor/app/shared/dio/dio_service.dart';
import 'package:flutter_leitor/app/shared/interfaces/repository_unique.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class MangaRepository extends Disposable implements RepositoryUnique {
  final DioService dio;

  MangaRepository(this.dio);

  @override
  Future<List<CapituloModel>> listarTitulo(TituloModel manga) async {
    String data = await dio.getLink(manga.link);
    Document soup = parse(data);
    manga.descricao =
        soup.querySelector('div.panel-body').text.trim().replaceAll('\n', '');
    List<Element> divs = soup.querySelectorAll("div.row.lancamento-linha");
    List<CapituloModel> capitulos = List();
    divs.forEach((data) {
      capitulos.add(CapituloModel(
          titulo: data.querySelector('a').text,
          link: data.querySelector('a').attributes['href'],
          info: data.querySelector('a').nextElementSibling.innerHtml));
    });
    return capitulos;
  }

  Future<List<String>> imagens(String link) async {
    String data = await dio.getLink(link);
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
