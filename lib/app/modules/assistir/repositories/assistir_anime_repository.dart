import 'package:flutter_leitor/app/shared/services/dio_service.dart';
import 'package:flutter_leitor/app/shared/models/episodio_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class AssistirAnimeRepository extends Disposable {
  final DioService dio;

  AssistirAnimeRepository(this.dio);

  Future<String> linkVideo(EpisodioModel ep) async {
    String data = await dio.getLink(ep.link);
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
      data = await dio.getLink(linkVideo);
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
