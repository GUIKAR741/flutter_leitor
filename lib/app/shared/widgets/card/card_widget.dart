import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:leitor/app/shared/models/titulo_model.dart';

class CardWidget extends StatelessWidget {
  final TituloModel titulo;

  const CardWidget({
    Key? key,
    required this.titulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: kIsWeb || Platform.isLinux
                  ? ExtendedImage.network(
                      titulo.imagem!,
                      height: 300,
                    )
                  : ExtendedImage.network(
                      titulo.imagem!,
                      height: 300,
                      fit: BoxFit.fill,
                    ),
            ),
          ],
        ),
        Container(
          color: Theme.of(context).backgroundColor,
          padding: const EdgeInsets.all(5),
          alignment: Alignment.centerLeft,
          child: Text(
            titulo.descricao!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
