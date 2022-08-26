import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor/app/shared/widgets/ler_controle/ler_controle_controller.dart';

class LerControle extends StatelessWidget {
  final LerControleController controller;
  final double barHeight = 48.0;
  final List<Widget> actions;

  final Widget title;

  const LerControle({
    Key? key,
    required this.title,
    required this.actions,
    required this.controller,
  }) : super(key: key);

  Widget _buildBottomBar(context) {
    return Observer(
      builder: (_) => AnimatedOpacity(
        opacity: controller.esconderControle ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          height: barHeight,
          color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: controller.esconderControle
                        ? null
                        : () => Modular.to.maybePop(),
                    tooltip: 'Voltar',
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                  title
                ],
              ),
              Row(
                children: actions,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: controller.mudar,
          child: _buildBottomBar(context),
        )
      ],
    );
  }
}
