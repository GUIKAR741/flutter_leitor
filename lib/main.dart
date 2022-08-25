import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:leitor/app/shared/models/capitulo_episodio_model.dart';
import 'package:leitor/app/shared/models/titulo_model.dart';
import 'package:leitor/firebase_options.dart';
import 'package:path_provider/path_provider.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/shared/util/constants.dart';

void main() async {
  if (kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (!kIsWeb) {
      FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
      if (kDebugMode) {
        // Force disable Crashlytics collection while doing every day development.
        // Temporarily toggle this to true if you want to test crash reporting in your app.
        await FirebaseCrashlytics.instance
            .setCrashlyticsCollectionEnabled(true);
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
    runApp(ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ));
  } else {
    runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
        if (!kIsWeb) {
          FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
          if (kDebugMode) {
            // Force disable Crashlytics collection while doing every day development.
            // Temporarily toggle this to true if you want to test crash reporting in your app.
            await FirebaseCrashlytics.instance
                .setCrashlyticsCollectionEnabled(true);
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
            FlutterError.onError =
                FirebaseCrashlytics.instance.recordFlutterError;
          }
        }
        final directory = await getApplicationDocumentsDirectory();
        try {
          await Hive.initFlutter(directory.path);
        } on HiveError catch (e) {
          debugPrint("$e");
        }
        Hive.registerAdapter<TituloModel>(TituloModelAdapter());
        Hive.registerAdapter<CapEpModel>(CapEpModelAdapter());
        await Hive.openBox<bool>(tema);
        await Hive.openBox<TituloModel>(hqs);
        await Hive.openBox<TituloModel>(mangas);
        await Hive.openBox<String>('data');
        runApp(
          ModularApp(
            module: AppModule(),
            child: const AppWidget(),
          ),
        );
      },
      (error, stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
    );
  }
}
