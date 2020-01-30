// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Flutter Leitor App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final lerHqs = find.text('Ler HQs');
    
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Text do botão é Ler HQs', () async {
      expect(await driver.getText(lerHqs), "Ler HQs");
    });

    test('increments the counter', () async {
      // First, tap the button.
      await driver.tap(lerHqs);
      final titulo = find.text('HQs');
      expect(await driver.getText(titulo), 'HQs');
    });
  });
}
