import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/models/episodio_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './app/app_module.dart';

void main() async {
  Crashlytics crashlytics = Crashlytics.instance;
  debugPrint = (String message, {int wrapWidth}) =>
      crashlytics.log("[${DateTime.now()}] : $message");
  FlutterError.onError = crashlytics.recordFlutterError;

  await Hive.initFlutter();
  Hive.registerAdapter<TituloModel>(TituloModelAdapter());
  Hive.registerAdapter<CapituloModel>(CapituloModelAdapter());
  Hive.registerAdapter<EpisodioModel>(EpisodioModelAdapter());

  WidgetsFlutterBinding.ensureInitialized();

  runZoned(
    () => runApp(ModularApp(module: AppModule())),
    onError: crashlytics.recordError,
  );
}
