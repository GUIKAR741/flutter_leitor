// import 'package:dio/dio.dart';
import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_leitor/app/shared/services/dio_service.dart';
// import 'package:mockito/mockito.dart';

// class DioMock extends Mock implements Dio{}

void main() {
  initModule(AppModule());
  DioService service;

  setUp(() {
    service = DioService();
  });

  group('DioService Test', () {
    test("First Test", () {
      expect(service, isInstanceOf<DioService>());
    });
  });
}
