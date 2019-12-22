import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/animes/animes_bloc.dart';
import 'package:flutter_leitor/app/modules/animes/animes_module.dart';
import 'package:flutter_leitor/app/modules/animes/widgets/pesquisar/pesquisar_anime_widget.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';

class AnimesPage extends StatefulWidget {
  final String title;
  const AnimesPage({Key key, this.title = "Animes"}) : super(key: key);

  @override
  _AnimesPageState createState() => _AnimesPageState();
}

class _AnimesPageState extends State<AnimesPage> {
  AnimesBloc bloc = AnimesModule.to.get<AnimesBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title), actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.refresh,
              ),
              onPressed: () => bloc.listar(refresh: true)),
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
            return ListView.separated(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                return ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  leading: Container(
                    height: 100,
                    width: 50,
                    child: ExtendedImage.network(snapshot.data[index].imagem,
                        cache: true, fit: BoxFit.fill),
                  ),
                  title: Text(snapshot.data[index].nome),
                  onTap: () {
                    // print(snapshot.data[index]);
                    Navigator.pushNamed(context, '/animes/anime',
                        arguments: snapshot.data[index]);
                  },
                );
              },
              separatorBuilder: (_, index) => Divider(),
            );
          },
        ));
  }
}
