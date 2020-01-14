import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_module.dart';
import 'package:flutter_leitor/app/modules/hqs/pages/hq/hq_bloc.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_leitor/app/shared/widgets/pesquisar/pesquisar_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PesquisarCapitulo extends Pesquisar {
  final Titulo hq;

  PesquisarCapitulo({
    @required this.hq,
  });

  HqBloc bloc = HqsModule.to.get<HqBloc>();

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          bloc.listarCapitulos();
          close(context, '');
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // close(context, query);
    bloc.pesquisar(query);
    return StreamBuilder(
      stream: bloc.dados,
      builder: (_, AsyncSnapshot<List<Capitulo>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.separated(
          itemCount: snapshot.data.length,
          itemBuilder: (_, index) {
            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
              title: Text(snapshot.data[index].titulo),
              onTap: () {
                Modular.to
                    .pushNamed('/hqs/ler_hq', arguments: snapshot.data[index]);
              },
            );
          },
          separatorBuilder: (_, index) => Divider(),
        );
      },
    );
  }
}
