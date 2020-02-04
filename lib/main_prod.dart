import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import './app/app_module.dart';

void main() {
  Crashlytics crashlytics = Crashlytics.instance;
  debugPrint = (String message, {int wrapWidth}) =>
      crashlytics.log("[${DateTime.now()}] : $message");
  FlutterError.onError = crashlytics.recordFlutterError;
  WidgetsFlutterBinding.ensureInitialized();
  runZoned(
    () => runApp(ModularApp(module: AppModule())),
    onError: crashlytics.recordError,
  );
}
