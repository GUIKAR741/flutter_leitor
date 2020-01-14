import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_bloc.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_module.dart';
import 'package:flutter_leitor/app/modules/hqs/widgets/pesquisar/pesquisar_hq_widget.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HqsPage extends StatelessWidget {
  final String title;
  final HqsBloc bloc = HqsModule.to.get<HqsBloc>();
  HqsPage({Key key, this.title = "HQs"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  showSearch(context: context, delegate: PesquisarHq());
                })
          ],
        ),
        body: StreamBuilder(
          stream: bloc.dados,
          builder: (_, AsyncSnapshot<List<Titulo>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return RefreshIndicator(
              onRefresh: () async {
                bloc.listar(refresh: true);
              },
              child: Scrollbar(
                controller: bloc.scroll,
                child: ListView.separated(
                  controller: bloc.scroll,
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                      leading: Container(
                        height: 100,
                        width: 50,
                        child: ExtendedImage.network(
                            snapshot.data[index].imagem,
                            cache: true,
                            fit: BoxFit.fill),
                      ),
                      title: Text(snapshot.data[index].nome),
                      onTap: () {
                        Modular.to.pushNamed('/hqs/hq',
                            arguments: snapshot.data[index]);
                      },
                    );
                  },
                  separatorBuilder: (_, index) => Divider(),
                ),
              ),
            );
          },
        ));
  }
}
