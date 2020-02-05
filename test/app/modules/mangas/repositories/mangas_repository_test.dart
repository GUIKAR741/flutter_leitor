import 'dart:io';

import 'package:flutter_leitor/app/shared/services/dio_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_leitor/app/modules/mangas/repositories/mangas_repository.dart';

class MockClient extends Mock implements DioService {}

void main() {
  Hive.init(Directory.current.path + "/hive");
  MangasRepository repository;
  MockClient client;

  setUp(() {
    client = MockClient();
    repository = MangasRepository(client);
  });

  group('MangasRepository Test', () {
    test("First Test", () {
      expect(repository, isInstanceOf<MangasRepository>());
    });

    // test('returns a Post if the http call completes successfully', () async {
      // when(getLink('https://jsonplaceholder.typicode.com/posts/1'))
      //     .thenAnswer(
      //         (_) async => Response(data: {'title': 'Test'}, statusCode: 200));
      // Map<String, dynamic> data = await repository.fetchPost(client);
      // expect(data['title'], 'Test');
    // });
  });
}
