import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/app_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  final AppController controller = Modular.get<AppController>();
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MaterialApp(
        navigatorKey: Modular.navigatorKey,
        title: 'Flutter Leitor',
        debugShowCheckedModeBanner: false,
        theme: controller.tema ? ThemeData.dark() : ThemeData.light(),
        initialRoute: '/',
        onGenerateRoute: Modular.generateRoute,
      );
    });
  }
}
