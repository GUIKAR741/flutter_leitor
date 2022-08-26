import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor/app/modules/home/home_module.dart';
import 'package:leitor/app/modules/hqs/hqs_module.dart';
import 'package:leitor/app/modules/mangas/mangas_module.dart';
import 'package:leitor/app/shared/controllers/auth_controller.dart';
import 'package:leitor/app/shared/controllers/firestore_controller.dart';
import 'package:leitor/app/shared/controllers/theme_store.dart';
import 'package:leitor/app/shared/repositories/auth_repository.dart';
import 'package:leitor/app/shared/services/dio_service.dart';
import 'package:leitor/app/shared/widgets/drawer/drawer_custom_controller.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    if (kIsWeb || !Platform.isLinux)
      Bind.lazySingleton((i) => AuthController()),
    if (kIsWeb || !Platform.isLinux)
      Bind.lazySingleton((i) => FirestoreController()),
    Bind.lazySingleton((i) => DioService()),
    Bind.lazySingleton((i) => ThemeStore()),
    Bind.lazySingleton((i) => DrawerCustomController()),
    if (kIsWeb || !Platform.isLinux)
      Bind.lazySingleton((i) => AuthRepository()),
    if (kIsWeb || !Platform.isLinux)
      Bind.singleton((i) => FirebaseAnalytics.instance),
    if (kIsWeb || !Platform.isLinux)
      Bind.singleton((i) => FirebaseAnalyticsObserver(analytics: i.get())),
    if (!kIsWeb && !Platform.isLinux)
      Bind.singleton((i) => FirebaseCrashlytics.instance),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      Modular.initialRoute,
      module: HomeModule(),
    ),
    ModuleRoute(
      '/hqs',
      module: HqsModule(),
    ),
    ModuleRoute(
      '/mangas',
      module: MangasModule(),
    ),
  ];
}
