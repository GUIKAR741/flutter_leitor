import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import './app/app_module.dart';

void main() {
  debugPrint = (String message, {int wrapWidth}) {};
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ModularApp(module: AppModule()));
}
