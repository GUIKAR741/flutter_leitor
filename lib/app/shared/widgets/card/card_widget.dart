import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';

class CardWidget extends StatelessWidget {
  final TituloModel titulo;

  const CardWidget({
    Key key,
    @required this.titulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: ExtendedImage.network(
                  titulo.imagem,
                  height: 300,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.blueGrey[700],
          padding: EdgeInsets.all(5),
          alignment: Alignment.centerLeft,
          child: Text(
            titulo.descricao,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
