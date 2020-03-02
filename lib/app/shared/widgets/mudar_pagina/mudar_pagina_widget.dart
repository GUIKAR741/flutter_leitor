import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MudarPaginaWidget extends StatelessWidget {
  final int paginas;
  final void Function(String) onPressed;

  const MudarPaginaWidget({
    Key key,
    @required this.paginas,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<RaisedButton> botoes = [];
    for (int i = 1; i <= paginas; i++) {
      botoes.add(
        RaisedButton(
          child: Text(
            i.toString(),
            style: TextStyle(
              fontSize: 10,
            ),
          ),
          onPressed: () => onPressed(i.toString()),
        ),
      );
    }
    return AlertDialog(
      title: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Modular.to.pop(),
          ),
          Text('Mudar Página'),
        ],
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: OrientationBuilder(builder: (_, Orientation orientation) {
          return GridView.count(
            primary: false,
            shrinkWrap: true,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            crossAxisCount: orientation == Orientation.portrait ? 4 : 6,
            children: botoes,
          );
        }),
      ),
    );
  }
}
