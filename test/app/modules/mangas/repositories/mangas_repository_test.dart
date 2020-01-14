import 'package:flutter_leitor/app/shared/dio/custom_dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_leitor/app/modules/mangas/repositories/mangas_repository.dart';

class MockCustom extends Mock implements CustomDio {}

void main() {
  MangasRepository repository;
  MockCustom custom;

  setUp(() {
    // client = MockClient();
    custom = MockCustom();
    repository = MangasRepository(custom);
  });

  group('MangasRepository Test', () {
    test("First Test", () {
      expect(repository, isInstanceOf<MangasRepository>());
    });

    test('returns a Post if the http call completes successfully', () async {
      // when(custom.client.get("https://leitor-mangas-flutter.firebaseio.com/dados/mangas.json"))
      //     .thenAnswer(
      //         (_) async => Response(data: {"id": [{"nome": "", "link": "", "imagem": ""}]}, statusCode: 200));
      // List<Titulo> data = await repository.pegarMangas(true);
      // expect(data, [Titulo(nome: "", link: "", imagem: "")]);
    });
  });
}
