import 'package:flutter_leitor/app/shared/dio/custom_dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_leitor/app/modules/mangas/repositories/manga_repository.dart';

class MockClient extends Mock implements CustomDio {}

void main() {
  MangaRepository repository;
  MockClient client;

  setUp(() {
    client = MockClient();
    repository = MangaRepository(client);
  });

  group('MangaRepository Test', () {
    test("First Test", () {
      // expect(repository, isInstanceOf<MangaRepository>());
    });

    test('returns a Post if the http call completes successfully', () async {
      // when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
      //     .thenAnswer(
      //         (_) async => Response(data: {'title': 'Test'}, statusCode: 200));
      // Map<String, dynamic> data = await repository.pegarManga('https://jsonplaceholder.typicode.com/posts/1');
      // expect(data['title'], 'Test');
    });
  });
}
