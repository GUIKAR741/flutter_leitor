// import 'package:dio/dio.dart';
import 'package:flutter_leitor/app/shared/dio/custom_dio.dart';
// import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_leitor/app/modules/animes/repositories/animes_repository.dart';

class MockClient extends Mock implements CustomDio {}

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
      // when(client.client.get("https://leitor-mangas-flutter.firebaseio.com/dados/animes.json"))
      //     .thenAnswer(
      //         (_) async => Response(data: {"id": [{"nome": "", "link": "", "imagem": ""}]}, statusCode: 200));
      // List<Titulo> data = await repository.pegarAnimes(true);
      // expect(data, [Titulo(nome: "", link: "", imagem: "")]);
    });
  });
}
