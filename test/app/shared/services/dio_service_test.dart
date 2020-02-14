// import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_leitor/app/shared/services/dio_service.dart';

import '../../../mock/dio_service_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  initModule(AppModule(), changeBinds: [
    Bind<DioService>((i) => DioServiceMock()),
  ]);
  DioService service;

  setUp(() {
    service = Modular.get<DioService>();
  });

  group('DioService Test', () {
    test("Service é instancia de DioService", () {
      expect(service, isInstanceOf<DioService>());
    });
    test("Requisição GET", () async {
      Map<String, dynamic> dados = await service.getLink(
          'https://leitor-mangas-flutter.firebaseio.com/dados/atualizacao.json');
      expect(
        dados,
        {
          "-M00fWr85knF_i3RdDOD": {
            "data": "2020-02-14 03:11:34",
          },
        },
      );
    });
    test("Requisição GET Erro", () async {
      (service as DioServiceMock).interceptorValidate = false;
      try {
        await service.getLink(
            'https://leitormangas-flutter.firebaseio.com/dados/atualizacao.json');
      } catch (e) {
        expect(e, isInstanceOf<DioError>());
      }
    });
    test("Requisição POST", () async {
      (service as DioServiceMock).interceptorValidate = true;
      Map<String, dynamic> dados = await service.postLink(
          'https://leitor-mangas-flutter.firebaseio.com/dados/atualizacao.json');
      expect(
        dados,
        {
          "-M00fWr85knF_i3RdDOD": {
            "data": "2020-02-14 03:11:34",
          },
        },
      );
    });
    test("Requisição POST Erro", () async {
      (service as DioServiceMock).interceptorValidate = false;
      try {
        await service.postLink(
            'https://leitormangas-flutter.firebaseio.com/dados/atualizacao.json');
      } catch (e) {
        expect(e, isInstanceOf<DioError>());
      }
    });
    test("Dispose", () async {
      expect(service.client, isInstanceOf<Dio>());
      service.dispose();
      try {
        await service.client.get('');
      } on DioError catch (e) {
        expect(e.error, "Dio can't establish new connection after closed.");
      }
    });
  });
}
