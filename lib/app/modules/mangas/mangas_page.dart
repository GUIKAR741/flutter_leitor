import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_bloc.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_module.dart';
import 'package:flutter_leitor/app/modules/mangas/widgets/pesquisar/pesquisar_manga_widget.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';

class MangasPage extends StatelessWidget {
  final String title;
  final MangasBloc bloc = MangasModule.to.get<MangasBloc>();

  MangasPage({Key key, this.title = "Mangas"}) : super(key: key);

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
                  showSearch(context: context, delegate: PesquisarManga());
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
                        Navigator.pushNamed(context, '/mangas/manga',
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
