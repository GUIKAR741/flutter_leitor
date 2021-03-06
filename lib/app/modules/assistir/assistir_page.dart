import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../modules/assistir/assistir_controller.dart';
import '../../shared/models/capitulo_episodio_model.dart';

class AssistirPage extends StatefulWidget {
  final CapEpModel episodio;
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
      body: Column(
        children: <Widget>[
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
        ],
      ),
    );
  }
}
