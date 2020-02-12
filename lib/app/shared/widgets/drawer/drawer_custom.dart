import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/shared/auth/auth_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import './drawer_custom_controller.dart';

class DrawerCustom extends StatelessWidget {
  final DrawerCustomController controller = DrawerCustomController();

  Column items() {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Inicio'),
          onTap: () => Modular.to.popUntil(ModalRoute.withName('/')),
        ),
        ListTile(
            leading: Icon(Icons.book),
            title: Text('HQs'),
            onTap: () {
              Modular.to.popUntil(ModalRoute.withName('/'));
              Modular.to.pushNamed('/hqs');
            }),
        ListTile(
          leading: Icon(Icons.image),
          title: Text('Mangás'),
          onTap: () {
            Modular.to.popUntil(ModalRoute.withName('/'));
            Modular.to.pushNamed('/mangas');
          },
        ),
        ListTile(
          leading: Icon(Icons.video_label),
          title: Text('Animes'),
          onTap: () {
            Modular.to.popUntil(ModalRoute.withName('/'));
            Modular.to.pushNamed('/animes');
          },
        ),
        controller.authController.status != AuthStatus.logged
            ? logar()
            : Container()
      ],
    );
  }

  ListTile logar() {
    return ListTile(
      leading: Icon(Icons.account_circle),
      title: Text("Logar"),
      onTap: controller.loginWithGoogle,
    );
  }

  Widget userAccount(context) {
    switch (controller.authController.status) {
      case AuthStatus.logged:
        return UserAccountsDrawerHeader(
          accountName: Text(controller.authController.user.displayName),
          accountEmail: Text(controller.authController.user.email),
          currentAccountPicture: CircleAvatar(
            backgroundImage: ExtendedImage.network(
              controller.authController.user.photoUrl,
            ).image,
          ),
          onDetailsPressed:
              controller.esconderLogout ? controller.mostrarLogout : null,
        );
      case AuthStatus.logoff:
      default:
        if (controller.loading)
          return DrawerHeader(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        return UserAccountsDrawerHeader(
          accountName: Text("Faça Login"),
          accountEmail: Text("para sincronizar seus dados"),
          onDetailsPressed: null,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              userAccount(context),
              controller.esconderLogout
                  ? items()
                  : ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text("Logout"),
                      onTap: () {
                        controller.mostrarLogout(value: true);
                        controller.logout();
                      },
                    )
            ],
          ),
        );
      },
    );
  }
}
