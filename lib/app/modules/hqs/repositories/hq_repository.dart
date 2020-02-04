import 'package:flutter_leitor/app/shared/services/dio_service.dart';
import 'package:flutter_leitor/app/shared/interfaces/repository_unique.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class HqRepository extends Disposable implements RepositoryUnique {
  final DioService dio;

  HqRepository(this.dio);

  @override
  Future<List<CapituloModel>> listarTitulo(TituloModel hq) async {
    String data = await dio.getLink(hq.link);
    Document soup = parse(data);
    hq.descricao = soup
        .querySelectorAll('div.col-md-8>p')
        .last
        .text
        .replaceAll('Sinopse:', '')
        .trim();
    List<Element> td = soup.querySelectorAll("td");
    List<CapituloModel> capitulos = List();
    td.forEach((data) {
      capitulos.add(CapituloModel(
          titulo: data.querySelector('a').text,
          link: data.querySelector('a').attributes['href']));
    });
    return capitulos;
  }

  Future<List<String>> imagens(String link) async {
    String data = await dio.getLink(link);
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
