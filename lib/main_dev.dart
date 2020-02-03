import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import './app/app_module.dart';

void main() {
  Crashlytics crashlytics = Crashlytics.instance;
  crashlytics.enableInDevMode = true;
  debugPrint = (String message, {int wrapWidth}) => debugPrintSynchronously(
        "[${DateTime.now()}] : $message",
        wrapWidth: wrapWidth,
      );
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    crashlytics.recordFlutterError(details);
  };
  WidgetsFlutterBinding.ensureInitialized();
  runZoned(
    () => runApp(ModularApp(module: AppModule())),
    onError: crashlytics.recordError,
  );
}
