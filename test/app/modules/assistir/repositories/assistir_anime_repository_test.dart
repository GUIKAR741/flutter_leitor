import 'package:flutter_leitor/app/shared/services/dio_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_leitor/app/modules/assistir/repositories/assistir_anime_repository.dart';

class MockClient extends Mock implements DioService {}

void main() {
  AssistirAnimeRepository repository;
  MockClient client;

  setUp(() {
    client = MockClient();
    repository = AssistirAnimeRepository(client);
  });

  group('AssistirAnimeRepository Test', () {
    test("First Test", () {
      expect(repository, isInstanceOf<AssistirAnimeRepository>());
    });

    test('returns a Post if the http call completes successfully', () async {
      // when(repository.dio.client.get('https://jsonplaceholder.typicode.com/posts/1'))
      //     .thenAnswer(
      //         (_) async => Response(data: {'title': 'Test'}, statusCode: 200));
      // Map<String, dynamic> data = await repository.fetchPost(client);
      // expect(data['title'], 'Test');
    });
  });
}
