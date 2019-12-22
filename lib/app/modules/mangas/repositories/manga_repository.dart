import 'package:flutter_leitor/app/shared/dio/custom_dio.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class MangaRepository extends Disposable {
  final CustomDio dio;

  MangaRepository(this.dio);
  
  Future<dynamic> _getLink(String link) async {
    final response = await dio.client.get(link);
    return response.data;
  }

  Future<List<Capitulo>> capitulos(String link) async{
    String data = await _getLink(link);
    Document soup = parse(data);
    List<Element> divs = soup.querySelectorAll("div.row.lancamento-linha");
    List<Capitulo> capitulos = List();
    divs.forEach((data){
      capitulos.add(Capitulo(
        titulo: data.querySelector('a').text,
        link: data.querySelector('a').attributes['href']
      ));
    });
    return capitulos;
  }
  
  Future<List<String>> imagens(String link) async{
    String data = await _getLink(link);
    Document soup = parse(data);
    return soup.querySelectorAll('img').where((e) => (e.attributes['pag']?.isNotEmpty ?? false) && e.attributes['src'].toString().contains('/leitor/')).map((e) => e.attributes['src']).toList();
  }

  @override
  void dispose() {
  }
}
