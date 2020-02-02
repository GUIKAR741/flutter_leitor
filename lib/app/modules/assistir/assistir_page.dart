import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_leitor/app/modules/assistir/assistir_controller.dart';
import 'package:flutter_leitor/app/shared/models/episodio_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AssistirPage extends StatefulWidget {
  final EpisodioModel episodio;
  AssistirPage({Key key, this.episodio}) : super(key: key);
  _AssistirPageState createState() => _AssistirPageState();
}

class _AssistirPageState
    extends ModularState<AssistirPage, AssistirController> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    controller.iniciarLink(widget.episodio);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Expanded(
          child: Center(
            child: Observer(
              builder: (_) {
                return controller.chewie.value != null
                    ? controller.chewie.value
                    : CircularProgressIndicator();
              },
            ),
          ),
        ),
      ]),
    );
  }
}
// class AssistirPage extends StatelessWidget {
//   final EpisodioModel episodio;
//   final AssistirController controller = Modular.get<AssistirController>();
//   AssistirPage({Key key, this.episodio}) : super(key: key);

//   @override
//   StatelessElement createElement() {
//     controller.iniciarLink(episodio);
//     return super.createElement();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(children: <Widget>[
//         Expanded(
//           child: Center(
//             child: Observer(
//               builder: (_) {
//                 return controller.chewie.value != null
//                     ? controller.chewie.value
//                     : CircularProgressIndicator();
//               },
//             ),
//           ),
//         ),
//       ]),
//     );
//   }
// }
