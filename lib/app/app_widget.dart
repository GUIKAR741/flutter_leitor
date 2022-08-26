import 'dart:io';

import 'package:asuka/asuka.dart' as asuka;
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor/app/shared/controllers/theme_store.dart';
import 'package:leitor/app/shared/util/app_scroll_behavior.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final FirebaseAnalyticsObserver? _observer =
      (kIsWeb || !Platform.isLinux) ? Modular.get() : null;
  final ThemeStore controller = Modular.get();

  @override
  Widget build(BuildContext context) {
    Modular.setObservers([
      asuka.asukaHeroController,
      if (_observer != null) _observer!,
    ]);
    Modular.setInitialRoute('/');
    return Observer(
      builder: (_) => MaterialApp.router(
        title: 'Leitor',
        scrollBehavior: AppScrollBehavior(),
        theme: ThemeData(primarySwatch: Colors.blue),
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
        themeMode: controller.temaValue ? ThemeMode.dark : ThemeMode.light,
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        builder: asuka.builder,
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
        ],
        locale: const Locale('pt', 'BR'),
      ),
    );
  }
}
