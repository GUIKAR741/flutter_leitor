import 'package:flutter_leitor/app/shared/dio/custom_dio.dart';
import 'package:flutter_leitor/app/shared/models/episodio_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'dart:convert';

class AnimeRepository extends Disposable {
  final CustomDio dio;

  AnimeRepository(this.dio);

  Future<dynamic> _getLink(String link) async {
    final response = await dio.client.get(link);
    return response.data;
  }

  Future<dynamic> _postLink(String link, Map<String, dynamic> data) async {
    final response = await dio.client.post(link, data: FormData.fromMap(data));
    return json.decode(response.data);
  }

  Future<List<Episodio>> episodios(Titulo anime) async {
    String data = await _getLink(anime.link);
    Document soup = parse(data), soupOriginal = parse(data);
    anime.descricao = soup.querySelector('p#sinopse').text.replaceAll('\n', '');
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
          String tempoEp =
              soup.querySelector('div.epsBoxImg > div.tempoEps').innerHtml;
          Element ep = soup.querySelector('div.epsBoxSobre');
          String imagem = ep.parent
              .querySelector('div.epsBoxImg')
              .querySelector('img')
              .attributes['src'];
          List<String> info = ep
              .querySelectorAll('img')
              .where((d) => d.attributes['alt']?.isNotEmpty ?? false)
              .map((e) => e.attributes['alt'])
              .toList()
              .reversed
              .toList();
          episodios.add(Episodio(
              titulo: ep.querySelector('a').text,
              link: ep.querySelector('a').attributes['href'],
              info:
                  'Idioma: ${info[0]} Legenda: ${info.length > 1 ? info[1] : 'Sem Legenda'} Duração: $tempoEp',
              imagem: imagem));
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
            String tempoEp = ep.querySelector('div.tempoEps').innerHtml;
            String imagem = ep
                .querySelector('div.epsBoxImg')
                .querySelector('img')
                .attributes['data-src'];
            List<String> info = ep
                .querySelectorAll('img')
                .where((d) => d.attributes['alt']?.isNotEmpty ?? false)
                .map((e) => e.attributes['alt'])
                .toList()
                .reversed
                .toList();
            episodios.add(Episodio(
                titulo:
                    "OVA: ${ep.querySelector('div.epsBoxSobre').querySelector('a').text}",
                link: ep.querySelector('a').attributes['href'],
                info:
                    'Idioma: ${info[0]} Legenda: ${info.length > 1 ? info[1] : 'Sem Legenda'} Duração: $tempoEp',
                imagem: imagem));
          }
        }
        // List<Element> filme = parent.querySelectorAll('div.epsBoxFilme');
        // if (filme.isNotEmpty) {
        //   for (Element ep in filme) {
        //     String imagem = ep
        //         .querySelector('div.epsBoxImgFilme')
        //         .querySelector('img')
        //         .attributes['data-src'];
        //     String tempoEp = ep.querySelector('div.tempoEps').innerHtml;
        //     List<String> info = ep
        //         .querySelectorAll('img')
        //         .where((d) => d.attributes['alt']?.isNotEmpty ?? false)
        //         .map((e) => e.attributes['alt'])
        //         .toList()
        //         .reversed
        //         .toList();
        //     episodios.add(Episodio(
        //         titulo: "Filme: ${ep.querySelector('h4').text}",
        //         link: ep.querySelector('a').attributes['href'],
        //         info:
        //             'Idioma: ${info[0]} Legenda: ${info.length > 1 ? info[1] : 'Sem Legenda'} Duração: $tempoEp',
        //         imagem: imagem));
        //   }
        // }
      }
    }
    return episodios;
  }

  Future<String> linkVideo(Episodio ep) async {
    String data = await _getLink(ep.link);
    Document soup = parse(data);
    ep.titulo = soup
        .querySelectorAll('h2')
        .where((e) =>
            e.attributes.containsKey('itemprop') &&
            e.attributes['itemprop'] == 'alternativeHeadline')
        .toList()[0]
        .text;
    dynamic linkVideo = soup.querySelector('source');
    String video;
    if (linkVideo != null) {
      video = (await dio.client.get(linkVideo.attributes['src'],
              options: Options(
                  headers: {'Referer': ep.link},
                  followRedirects: false,
                  receiveDataWhenStatusError: true,
                  validateStatus: (i) => true)))
          .headers
          .value('location');
    } else {
      List baixar = soup
          .querySelectorAll('a')
          .where((e) => e.attributes['title'] == 'Baixar Video')
          .toList();
      if (baixar.length == 0) {
        return 'link_invalido';
      }
      linkVideo = baixar[0].attributes['href'];
      data = await _getLink(linkVideo);
      soup = parse(data);
      linkVideo = soup.querySelector('a.bt-download').attributes['href'];
      video = (await dio.client.get(linkVideo,
              options: Options(
                  headers: {'Referer': ep.link},
                  followRedirects: false,
                  receiveDataWhenStatusError: true,
                  validateStatus: (i) => true)))
          .headers
          .value('location');
    }
    return video;
  }

  @override
  void dispose() {}
}
