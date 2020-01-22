import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_leitor/app/shared/dio/dio_service.dart';
// import 'package:mockito/mockito.dart';

// class DioMock extends Mock implements Dio{}

void main() {
  DioService service;

  setUp(() {
    service = DioService(Dio());
  });

  group('DioService Test', () {
    test("First Test", () {
      expect(service, isInstanceOf<DioService>());
    });
  });
}
