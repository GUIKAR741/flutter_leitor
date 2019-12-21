import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_bloc.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_module.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';

class MangasPage extends StatefulWidget {
  final String title;
  const MangasPage({Key key, this.title = "Mangas"}) : super(key: key);

  @override
  _MangasPageState createState() => _MangasPageState();
}

class _MangasPageState extends State<MangasPage> {
  MangasBloc bloc = MangasModule.to.get<MangasBloc>(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder(
            stream: bloc.dados,
            builder: (_, AsyncSnapshot<List<Titulo>> snapshot){
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator());
              }
              return ListView.separated(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index){
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    leading: Container(
                      height: 100,
                      width: 50,
                      child: Image.network(snapshot.data[index].imagem),
                    ),
                    title: Text(snapshot.data[index].nome),
                    onTap: (){
                      Navigator.pushNamed(
                        context, 
                        '/mangas/manga',
                        arguments: snapshot.data[index]
                      );
                    },
                  );
                },
                separatorBuilder: (_, index) => Divider(),
              );
            },
          )
    );
  }
}
