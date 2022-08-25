import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import './drawer_custom_controller.dart';
import '../../controllers/auth_controller.dart';

class DrawerCustom extends StatelessWidget {
  final DrawerCustomController controller = Modular.get();

  DrawerCustom({Key? key}) : super(key: key);

  Column items() {
    return Column(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Inicio'),
          onTap: () =>
              Modular.to.pushNamedAndRemoveUntil('/', ModalRoute.withName('/')),
        ),
        ListTile(
          leading: const Icon(Icons.book),
          title: const Text('HQs'),
          onTap: () => Modular.to.pushNamedAndRemoveUntil(
            '/hq/',
            ModalRoute.withName('/'),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.image),
          title: const Text('Mangás'),
          onTap: () => Modular.to.pushNamedAndRemoveUntil(
            '/mangas/',
            ModalRoute.withName('/'),
          ),
        ),
        // ListTile(
        //   leading: const Icon(Icons.video_label),
        //   title: const Text('Animes'),
        //   onTap: () => Modular.to.pushNamedAndRemoveUntil(
        //     '/animes',
        //     ModalRoute.withName('/'),
        //   ),
        // ),
        controller.authController.status != AuthStatus.logged
            ? logar()
            : Container()
      ],
    );
  }

  ListTile logar() {
    return ListTile(
      leading: const Icon(Icons.account_circle),
      title: const Text("Logar"),
      onTap: controller.loginWithGoogle,
    );
  }

  Widget userAccount(context) {
    switch (controller.authController.status) {
      case AuthStatus.logged:
        return UserAccountsDrawerHeader(
          accountName: Text(controller.authController.user!.displayName!),
          accountEmail: Text(controller.authController.user!.email!),
          currentAccountPicture: CircleAvatar(
            backgroundImage: ExtendedImage.network(
              controller.authController.user!.photoURL!
                  .replaceAll("s96-c", "s192-c")
                  .toString(),
            ).image,
          ),
          onDetailsPressed: controller.mostrarLogout,
        );
      case AuthStatus.logoff:
      default:
        if (controller.loading) {
          return const DrawerHeader(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return const UserAccountsDrawerHeader(
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
                      leading: const Icon(Icons.exit_to_app),
                      title: const Text("Logout"),
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
