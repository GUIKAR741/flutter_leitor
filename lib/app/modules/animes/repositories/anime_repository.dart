import 'package:flutter_leitor/app/shared/models/episodio_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'dart:convert';

class AnimeRepository extends Disposable {
  final Dio client;

  AnimeRepository(this.client);

  Future _getLink(String link) async {
    final response = await client.get(link);
    return response.data;
  }

  Future _postLink(String link, Map<String, dynamic> data) async {
    final response = await client.post(link, data: FormData.fromMap(data));
    return json.decode(response.data);
  }

  Future<List<Episodio>> episodios(String link) async {
    String data = await _getLink(link);
    Document soup = parse(data), soupOriginal = parse(data);
    String idCategoria = soup
        .querySelectorAll("div")
        .where((e) => e.attributes['data-id-cat'] != null)
        .toList()
        .map((e) => e.attributes['data-id-cat'])
        .toList()[0];
    int inicio = 1, fim = 20;
    Map<String, dynamic> pagina;
    List<Episodio> episodios = List();
    while (inicio <= fim) {
      Map<String, dynamic> data = {
        'id_cat': idCategoria.toString(),
        'page': inicio.toString(),
        'limit': 100.toString(),
        'total_page': fim.toString(),
        'order_video': 'asc'
      };
      pagina = await _postLink(
          "https://www.superanimes.org/inc/paginatorVideo.inc.php", data);
      fim = pagina['total_page'];
      inicio++;
      if (fim > 0) {
        for (String item in pagina['body']) {
          soup = parse(item);
          Element ep = soup.querySelector('div.epsBoxSobre');
          // print(ep.parent.querySelector('div.epsBoxImg').querySelector('img').attributes['src']);
          String imagem = ep.parent.querySelector('div.epsBoxImg').querySelector('img').attributes['src'];
          List<String> info = ep.querySelectorAll('img').where((d) => d.attributes['alt']?.isNotEmpty ?? false).map((e)=>e.attributes['alt']).toList().reversed.toList();
          episodios.add(Episodio(
              titulo: ep.querySelector('a').text,
              link: ep.querySelector('a').attributes['href'],
              info: 'Idioma: ${info[0]} Legenda: ${info.length > 1 ? info[1] : 'Sem Legenda'}',
              imagem: imagem
            )
          );
        }
      }
    }
    List<Element> box =
        soupOriginal.querySelectorAll("div.conteudoBox > div.js_dropDownView");
    if (box.isNotEmpty) {
      for (Element elemento in box) {
        Element parent = elemento.parent;
        List<Element> ova = parent.querySelectorAll('div.epsBox');
        if (ova.isNotEmpty) {
          for (Element ep in ova) {
            String imagem = ep.querySelector('div.epsBoxImg').querySelector('img').attributes['data-src'];
            List<String> info = ep.querySelectorAll('img').where((d) => d.attributes['alt']?.isNotEmpty ?? false).map((e)=>e.attributes['alt']).toList().reversed.toList();
            episodios.add(Episodio(
                titulo:
                    "OVA: ${ep.querySelector('div.epsBoxSobre').querySelector('a').text}",
                link: ep.querySelector('a').attributes['href'],
                info: 'Idioma: ${info[0]} Legenda: ${info.length > 1 ? info[1] : 'Sem Legenda'}',
                imagem: imagem
              )
            );
          }
        }
        List<Element> filme = parent.querySelectorAll('div.epsBoxFilme');
        if (filme.isNotEmpty) {
          for (Element ep in filme) {
            String imagem = ep.querySelector('div.epsBoxImgFilme').querySelector('img').attributes['data-src'];
            List<String> info = ep.querySelectorAll('img').where((d) => d.attributes['alt']?.isNotEmpty ?? false).map((e)=>e.attributes['alt']).toList().reversed.toList();
            episodios.add(Episodio(
                titulo: "Filme: ${ep.querySelector('h4').text}",
                link: ep.querySelector('a').attributes['href'],
                info: 'Idioma: ${info[0]} Legenda: ${info.length > 1 ? info[1] : 'Sem Legenda'}',
                imagem: imagem
              )
            );
          }
        }
      }
    }
    return episodios;
  }

  @override
  void dispose() {}
}
