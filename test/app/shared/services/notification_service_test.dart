import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_leitor/app/shared/services/notification_service.dart';

void main() {
  NotificationService service;

  setUp(() {
    service = NotificationService();
  });

  group('NotificationService Test', () {
    test("First Test", () {
      expect(service, isInstanceOf<NotificationService>());
    });
  });
}
