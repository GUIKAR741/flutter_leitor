import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MudarPaginaWidget extends StatelessWidget {
  final Widget child;
  final void Function(String) onChanged;
  final void Function() onPressed;

  const MudarPaginaWidget({Key key, this.child, this.onChanged, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text('Mudar Página'),
                  content: TextField(
                    decoration:
                        InputDecoration(labelText: "Digite o numero da Página"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered,
                    onChanged: onChanged,
                  ),
                  actions: <Widget>[
                    RaisedButton(
                      child: Text("Ir para Página"),
                      onPressed: onPressed,
                    )
                  ],
                );
              });
        },
        child: child);
  }
}
