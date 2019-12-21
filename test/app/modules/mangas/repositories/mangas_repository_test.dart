import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import 'package:flutter_leitor/app/modules/mangas/repositories/mangas_repository.dart';

class MockClient extends Mock implements Dio {}

void main() {
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

    test('returns a Post if the http call completes successfully', () async {
      when(client.get("https://leitor-mangas-flutter.firebaseio.com/dados/mangas.json"))
          .thenAnswer(
              (_) async => Response(data: {"id": [{"nome": "", "link": "", "imagem": ""}]}, statusCode: 200));
      List<Titulo> data = await repository.pegarMangas();
      expect(data, [Titulo(nome: "", link: "", imagem: "")]);
    });
  });
}
