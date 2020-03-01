import 'package:dio/dio.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_episodio_model.dart';
import 'package:flutter_leitor/app/shared/services/dio_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

abstract class IRepositoryAssistir implements Disposable {
  final DioService dio = Modular.get<DioService>();

  Future<String> linkVideo(CapEpModel ep, {CancelToken cancel}) async {
    String data;
    try {
      data = await dio.getLink(ep.link,
          contextError: 'Falha ao Procurar Episodio',
          refresh: true,
          cancelToken: cancel);
    } on DioError catch (e) {
      if (e.request == null) return 'link_invalido';
    }
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
    Response responseVideo;
    if (linkVideo != null) {
      try {
        responseVideo = await dio.getLink(
          linkVideo,
          options: Options(
            headers: {'Referer': ep.link},
            followRedirects: false,
            receiveDataWhenStatusError: true,
            validateStatus: (i) => true,
          ),
          cancelToken: cancel,
          refresh: true,
          returnResponse: true,
          contextError: "Falha ao Requisitar Video",
        );
      } on DioError catch (e) {
        if (e.request == null) return 'link_invalido';
      }
      video = responseVideo.headers.value('location');
    } else {
      List baixar = soup
          .querySelectorAll('a')
          .where((e) => e.attributes['title'] == 'Baixar Video')
          .toList();
      if (baixar.length == 0) {
        return 'link_invalido';
      }
      linkVideo = baixar[0].attributes['href'];
      String data;
      try {
        data = await dio.getLink(
          linkVideo,
          refresh: true,
          cancelToken: cancel,
          contextError: "Falha ao Requisitar Video",
        );
      } on DioError catch (e) {
        if (e.request == null) return 'link_invalido';
      }
      soup = parse(data);
      linkVideo = soup.querySelector('a.bt-download').attributes['href'];
      try {
        responseVideo = await dio.getLink(
          linkVideo,
          cancelToken: cancel,
          options: Options(
            headers: {'Referer': ep.link},
            followRedirects: false,
            receiveDataWhenStatusError: true,
            validateStatus: (i) => true,
          ),
          refresh: true,
          returnResponse: true,
          contextError: "Falha ao Requisitar Video",
        );
      } on DioError catch (e) {
        if (e.request == null) return 'link_invalido';
      }
      video = responseVideo.headers.value('location');
    }
    return video;
  }
}
