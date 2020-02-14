import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';

class DioMockAdapter extends HttpClientAdapter {
  DefaultHttpClientAdapter _adapter = DefaultHttpClientAdapter();
  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>> requestStream, Future cancelFuture) async {
    Uri uri = options.uri;
    switch (uri.host) {
      case "www.superanimes.org":
        switch (uri.path) {
          case "/inc/paginatorVideo.inc.php":
            break;
        }
        break;
      case "leitor-mangas-flutter.firebaseio.com":
        switch (uri.path) {
          case "/dados/animes.json":
            break;
          case "/dados/hqs.json":
            break;
          case "/dados/mangas.json":
            break;
          case "/dados/atualizacao.json":
            return ResponseBody.fromString(
              jsonEncode(
                {
                  "-M00fWr85knF_i3RdDOD": {
                    "data": "2020-02-14 03:11:34",
                  },
                },
              ),
              200,
              headers: {
                Headers.contentTypeHeader: [
                  Headers.jsonContentType,
                ]
              },
            );
            break;
        }
        break;
    }
    return _adapter.fetch(options, requestStream, cancelFuture);
  }

  @override
  void close({bool force = false}) {
    _adapter.close(force: force);
  }
}
