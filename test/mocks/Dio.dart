import 'package:dio/dio.dart';
import 'package:flutter_leitor/app/shared/services/dio_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mockito/mockito.dart';
import 'package:vcr/vcr.dart';

class DioMock extends Mock implements Dio {
  @override
  Type get runtimeType => Dio;

  DioMock(){
    print('Dio Mock');
  }
}

class DioServiceMock extends Disposable implements DioService{
  final Dio client = Modular.get<Dio>();
  VcrAdapter adapter = VcrAdapter();

  DioServiceMock(){
    client.httpClientAdapter = adapter;
  }

  set cassette(String path)=> adapter.useCassette(path);

  @override
  Type get runtimeType => DioService;

  @override
  Future getLink(String link,
      {bool returnResponse = false,
      bool refresh = false,
      Options options,
      String contextError}) async {
    Response response;
    try {
      response = await client.get(
        link,
      );
    } on DioError catch (_) {}
    return returnResponse ? response : response.data;
  }

  @override
  Future postLink(String link,
      {dynamic data,
      bool returnResponse = false,
      bool refresh = false,
      Options options,
      String contextError}) async {
    Response response;
    try {
      response = await client.post(
        link,
        data: data,
      );
    } on DioError catch (_) {}
    return returnResponse ? response : response.data;
  }

  @override
  void dispose() {
    client.close();
  }
}
