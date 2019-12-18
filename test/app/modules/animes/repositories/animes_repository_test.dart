import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import 'package:flutter_leitor/app/modules/animes/repositories/animes_repository.dart';

class MockClient extends Mock implements Dio {}

void main() {
  AnimesRepository repository;
  MockClient client;

  setUp(() {
    client = MockClient();
    repository = AnimesRepository(client);
  });

  group('AnimesRepository Test', () {
    test("First Test", () {
      expect(repository, isInstanceOf<AnimesRepository>());
    });

    test('returns a Post if the http call completes successfully', () async {
      when(client.get("https://leitor-mangas-flutter.firebaseio.com/dados/animes.json"))
          .thenAnswer(
              (_) async => Response(data: {'title': 'Test'}, statusCode: 200));
      Map<String, dynamic> data = await repository.fetchPost();
      expect(data['title'], 'Test');
    });
  });
}