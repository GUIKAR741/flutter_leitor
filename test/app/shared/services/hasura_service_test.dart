import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_leitor/app/shared/services/hasura_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HasuraService service;

  setUp(() {
    service = HasuraService();
  });

  group('HasuraService Test', () {
    test("First Test", () {
      expect(service, isInstanceOf<HasuraService>());
    });
  });
}
