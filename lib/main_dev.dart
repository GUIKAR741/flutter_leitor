import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import './app/app_module.dart';

void main() {
  debugPrint = (String message, {int wrapWidth}) => debugPrintSynchronously(
        "[${DateTime.now()}] : $message",
        wrapWidth: wrapWidth,
      );
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ModularApp(module: AppModule()));
}
