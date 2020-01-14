import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/app_bloc.dart';
import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: AppModule.to.get<AppBloc>().tema,
        builder: (context, snapshot) {
          ThemeData tema = ThemeData.dark();
          return MaterialApp(
            title: 'Flutter Leitor',
            debugShowCheckedModeBanner: false,
            theme: !snapshot.hasData
                ? tema
                : (snapshot.data ? ThemeData.dark() : ThemeData.light()),
            initialRoute: '/',
            onGenerateRoute: Modular.generateRoute,
            navigatorKey: Modular.navigatorKey,
          );
        });
  }
}
