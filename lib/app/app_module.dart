import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/app_controller.dart';
import 'package:flutter_leitor/app/app_widget.dart';
import 'package:flutter_leitor/app/modules/home/home_module.dart';
import 'package:flutter_leitor/app/shared/services/dio_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/animes/animes_module.dart';
import 'modules/assistir/assistir_module.dart';
import 'modules/hqs/hqs_module.dart';
import 'modules/mangas/mangas_module.dart';

class AppModule extends MainModule {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static Crashlytics crashlytics = Crashlytics.instance;

  @override
  List<Bind> get binds => [
        Bind<Dio>((i) => Dio()),
        Bind<DioService>((i) => DioService()),
        Bind<AppController>((i) => AppController()),
        Bind<FirebaseAnalytics>((i) => analytics),
        Bind<Crashlytics>((i) => crashlytics),
      ];

  @override
  List<Router> get routers => [
        Router(
          Modular.initialRoute,
          module: HomeModule(),
        ),
        Router(
          '/mangas',
          module: MangasModule(),
        ),
        Router(
          '/animes',
          module: AnimesModule(),
        ),
        Router(
          '/assistir',
          module: AssistirModule(),
        ),
        Router(
          '/hqs',
          module: HqsModule(),
        ),
      ];

  @override
  Widget get bootstrap => App(
        analytics: analytics,
      );

  static Inject get to => Inject<AppModule>.of();
}
