import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app_module.dart';
import 'app/shared/models/titulo_model.dart';
import 'app/shared/models/capitulo_episodio_model.dart';

void main() async {
  Crashlytics crashlytics = Crashlytics.instance;
  debugPrint = (String message, {int wrapWidth}) =>
      crashlytics.log("[${DateTime.now()}] : $message");
  FlutterError.onError = crashlytics.recordFlutterError;
  Modular.debugMode = false;

  await Hive.initFlutter();
  Hive.registerAdapter<TituloModel>(TituloModelAdapter());
  Hive.registerAdapter<CapEpModel>(CapEpModelAdapter());

  WidgetsFlutterBinding.ensureInitialized();

  runZoned(
    () => runApp(ModularApp(module: AppModule())),
    onError: crashlytics.recordError,
  );
}
