import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/shared/controllers/firestore_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'modules/animes/animes_module.dart';
import 'modules/assistir/assistir_module.dart';
import 'modules/home/home_module.dart';
import 'modules/hqs/hqs_module.dart';
import 'modules/mangas/mangas_module.dart';
import 'shared/controllers/auth_controller.dart';
import 'shared/interfaces/auth.dart';
import 'shared/repositories/auth_repository.dart';
import 'shared/services/dio_service.dart';
import 'shared/services/notification_service.dart';
import 'shared/widgets/drawer/drawer_custom_controller.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind<NotificationService>((i) => NotificationService()),
        Bind<IAuthRepository>((i) => AuthRepository()),
        Bind<AuthController>((i) => AuthController()),
        Bind<FirestoreController>((i) => FirestoreController()),
        Bind<DioService>((i) => DioService()),
        Bind<AppController>((i) => AppController()),
        Bind<DrawerCustomController>((i) => DrawerCustomController()),
        Bind<FirebaseAnalytics>((i) => FirebaseAnalytics()),
        Bind<Crashlytics>((i) => Crashlytics.instance),
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
  Widget get bootstrap => App();

  static Inject get to => Inject<AppModule>.of();
}
