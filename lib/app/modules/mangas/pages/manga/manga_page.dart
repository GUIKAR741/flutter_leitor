import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_module.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/manga/manga_bloc.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';

class MangaPage extends StatefulWidget {
  final Titulo manga;
  const MangaPage({Key key, this.manga}) : super(key: key);

  @override
  _MangaPageState createState() => _MangaPageState();
}

class _MangaPageState extends State<MangaPage> {
  MangaBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = MangasModule.to.get<MangaBloc>();
    bloc.manga = widget.manga;
    bloc.listarCapitulos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.manga.nome),
        ),
        body: StreamBuilder(
          stream: bloc.dados,
          builder: (_, AsyncSnapshot<List<Capitulo>> snapshot) {
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
                        title: Text(snapshot.data[index].titulo),
                      );
                    },
                    separatorBuilder: (_, index) => Divider(),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
