import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/shared/services/dio_service.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_leitor/app/modules/mangas/repositories/manga_repository.dart';

class MockClient extends Mock implements DioService {}

void main() {
  initModule(AppModule());
  MangaRepository repository;
  // MockClient client;

  setUp(() {
    // client = MockClient();
    repository = MangaRepository();
  });

  group('MangaRepository Test', () {
    test("First Test", () {
      expect(repository, isInstanceOf<MangaRepository>());
    });

    // test('returns a Post if the http call completes successfully', () async {
    //   when(getLink('https://jsonplaceholder.typicode.com/posts/1'))
    //       .thenAnswer(
    //           (_) async => Response(data: {'title': 'Test'}, statusCode: 200));
    //   Map<String, dynamic> data = await repository.fetchPost(client);
    //   expect(data['title'], 'Test');
    // });
  });
}
