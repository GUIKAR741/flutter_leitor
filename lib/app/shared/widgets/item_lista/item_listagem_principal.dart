import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../models/titulo_model.dart';

class ItemListagemPrincipal extends StatelessWidget {
  final TituloModel titulo;
  final Function(TituloModel) onPressed;
  final String rota;

  const ItemListagemPrincipal({
    Key key,
    @required this.titulo,
    @required this.onPressed,
    @required this.rota,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      leading: Container(
        height: 100,
        width: 50,
        child:
            ExtendedImage.network(titulo.imagem, cache: true, fit: BoxFit.fill),
      ),
      title: Text(titulo.nome),
      trailing: Observer(builder: (_) {
        return IconButton(
          icon: Icon(
            titulo.favorito ? Icons.star : Icons.star_border,
          ),
          tooltip: titulo.favorito ? "Desmarcar" : "Marcar",
          onPressed: () => onPressed(titulo),
        );
      }),
      onTap: () => Modular.to.pushNamed(
        rota,
        arguments: titulo,
      ),
    );
  }
}
