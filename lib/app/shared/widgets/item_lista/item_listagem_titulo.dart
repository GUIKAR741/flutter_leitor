import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor/app/shared/controllers/listagem_titulo.dart';
import 'package:leitor/app/shared/models/capitulo_episodio_model.dart';

class ItemListagemTitulo extends StatelessWidget {
  final ListagemTitulo controller;
  final CapEpModel capEp;
  final Function(String, CapEpModel, {bool add}) onPressed;
  final Function()? onLongPress;
  final String rota;

  const ItemListagemTitulo({
    Key? key,
    required this.controller,
    required this.capEp,
    required this.onPressed,
    required this.rota,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      leading: capEp.imagem != null && capEp.imagem!.isNotEmpty
          ? SizedBox(
              height: 100,
              width: 70,
              child: ExtendedImage.network(
                capEp.imagem!,
                cache: true,
                fit: BoxFit.fill,
              ),
            )
          : null,
      title: Text(capEp.titulo!),
      subtitle: capEp.info != null ? Text(capEp.info!) : null,
      trailing: Observer(
        builder: (_) {
          return IconButton(
            icon: Icon(
              capEp.status ? Icons.check_box : Icons.check_box_outline_blank,
            ),
            tooltip: capEp.status ? "Lido" : "Não Lido",
            onPressed: () => onPressed(capEp.tituloFormatado!, capEp),
          );
        },
      ),
      onTap: () {
        onPressed(
          capEp.tituloFormatado!,
          capEp,
          add: true,
        );
        Modular.to.pushNamed(
          rota,
          arguments: {
            'controller': controller,
            'capEp': capEp,
          },
        );
      },
      onLongPress: onLongPress,
    );
  }
}
