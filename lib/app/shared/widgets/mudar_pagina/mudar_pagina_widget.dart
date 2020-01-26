import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MudarPaginaWidget extends StatelessWidget {
  final Widget child;
  final int paginas;
  final void Function(String) onChanged;
  final void Function() onPressed;

  const MudarPaginaWidget({
    Key key,
    @required this.child,
    @required this.paginas,
    @required this.onChanged,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<RaisedButton> botoes = [];
    for (int i = 1; i <= paginas; i++) {
      botoes.add(RaisedButton(
        child: Text(
          i.toString(),
          style: TextStyle(
            fontSize: 10,
          ),
        ),
        onPressed: () {
          onChanged(i.toString());
          Modular.to.pop();
          onPressed();
        },
      ));
    }
    return FlatButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
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
                  content: GridView.count(
                    primary: false,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    crossAxisCount: 4,
                    children: botoes,
                  ),
                );
              });
        },
        child: child);
  }
}
