import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/animes/animes_bloc.dart';
import 'package:flutter_leitor/app/modules/animes/animes_module.dart';
import 'package:flutter_leitor/app/modules/animes/widgets/pesquisar/pesquisar_anime_widget.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AnimesPage extends StatelessWidget {
  final String title;
  final AnimesBloc bloc = AnimesModule.to.get<AnimesBloc>();

  AnimesPage({Key key, this.title = "Animes"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title), actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
              ),
              onPressed: () {
                showSearch(context: context, delegate: PesquisarAnime());
              })
        ]),
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
                controller: bloc.scrollController,
                child: ListView.separated(
                  controller: bloc.scrollController,
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                      leading: ExtendedImage.network(
                          snapshot.data[index].imagem,
                          width: 50,
                          cache: true,
                          enableMemoryCache: true,
                          fit: BoxFit.fill),
                      title: Text(snapshot.data[index].nome),
                      onTap: () {
                        Modular.to.pushNamed('/animes/anime',
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
