import 'package:flutter/material.dart';

class MudarPaginaWidget extends StatelessWidget {
  final int paginas;
  final void Function(String) onPressed;

  const MudarPaginaWidget({
    Key? key,
    required this.paginas,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ElevatedButton> botoes = [];
    for (int i = 1; i <= paginas; i++) {
      botoes.add(
        ElevatedButton(
          child: Text(
            i.toString(),
            style: const TextStyle(
              fontSize: 14,
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
            icon: const Icon(Icons.arrow_back),
            onPressed: Navigator.of(context).pop,
          ),
          const Text('Mudar Página'),
        ],
      ),
      content: SizedBox(
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
