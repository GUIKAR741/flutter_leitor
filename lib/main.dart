import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:leitor/app/app_module.dart';
import 'package:leitor/app/app_widget.dart';
import 'package:leitor/app/shared/models/capitulo_episodio_model.dart';
import 'package:leitor/app/shared/models/titulo_model.dart';
import 'package:leitor/app/shared/util/constants.dart';
import 'package:leitor/firebase_options.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb || !Platform.isLinux) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  if (!kIsWeb && !Platform.isLinux) {
    FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
    if (kDebugMode) {
      // Force disable Crashlytics collection while doing every day development.
      // Temporarily toggle this to true if you want to test crash reporting in your app.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.dumpErrorToConsole(details);
        crashlytics.recordFlutterError(details);
      };
      debugPrint = (String? message, {int? wrapWidth}) {
        debugPrintSynchronously(
          "--[${DateTime.now()}] : $message",
          wrapWidth: wrapWidth,
        );
      };
    } else {
      // Handle Crashlytics enabled status when not in Debug,
      // e.g. allow your users to opt-in to crash reporting.
      debugPrint = (String? message, {int? wrapWidth}) =>
          crashlytics.log("[${DateTime.now()}] : $message");
      crashlytics.isCrashlyticsCollectionEnabled;
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    }
  }
  try {
    await Hive.initFlutter();
  } on HiveError catch (e) {
    debugPrint("$e");
  }
  Hive.registerAdapter<TituloModel>(TituloModelAdapter());
  Hive.registerAdapter<CapEpModel>(CapEpModelAdapter());
  await Hive.openBox<bool>(tema);
  await Hive.openBox<TituloModel>(hqs);
  await Hive.openBox<TituloModel>(mangas);
  await Hive.openBox<String>('data');
  if (kIsWeb) {
    setPathUrlStrategy();
    runApp(
      ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    );
  } else if (Platform.isLinux) {
    runApp(
      ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    );
  } else {
    runZonedGuarded(
      () async => runApp(
        ModularApp(
          module: AppModule(),
          child: const AppWidget(),
        ),
      ),
      (error, stack) => FirebaseCrashlytics.instance.recordError(
        error,
        stack,
        fatal: true,
      ),
    );
  }
}
