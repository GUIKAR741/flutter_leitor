import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/animes/animes_module.dart';
import 'package:flutter_leitor/app/modules/animes/pages/anime/anime_bloc.dart';
import 'package:flutter_leitor/app/shared/models/episodio_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';

class AnimePage extends StatefulWidget {
  final Titulo anime;
  const AnimePage({Key key, this.anime}) : super(key: key);

  @override
  _AnimePageState createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  AnimeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = AnimesModule.to.get<AnimeBloc>();
    bloc.anime = widget.anime;
    bloc.listarEpisodios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.anime.nome),
        ),
        body:
        //  Center(
        //   child: RaisedButton(
        //     child: Text("Aperte"),
        //     onPressed: bloc.listarEpisodios,
        //   ),
        // )
        StreamBuilder(
          stream: bloc.dados,
          builder: (_, AsyncSnapshot<List<Episodio>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.separated(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        leading: Container(
                          height: 100,
                          width: 50,
                          child: Image.network(snapshot.data[index].imagem),
                        ),
                        title: Text(snapshot.data[index].titulo),
                        subtitle: Text(snapshot.data[index].info),
                      );
                    },
                    separatorBuilder: (_, index) => Divider(),
                  ),
                ),
              ],
            );
          },
        )
        );
  }
}
