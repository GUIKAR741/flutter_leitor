import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:leitor/app/shared/interfaces/repository_principal.dart';
import 'package:leitor/app/shared/models/titulo_model.dart';
import 'package:leitor/app/shared/util/constants.dart';

class MangasRepository extends IRepositoryPrincipal {
  @override
  Future<List<TituloModel>>? pegarListagem({
    bool refresh = false,
    CancelToken? cancel,
  }) async {
    if (!Hive.isBoxOpen('data')) {
      await Hive.openBox<String>('data');
    }
    Box<String> boxData = Hive.box<String>('data');
    if (refresh) {
      String data = await verificaData(cancel: cancel);
      boxData.put('data_mangas', data);
    } else {
      if (boxData.containsKey('data_mangas')) {
        DateTime dataSalva = DateTime.parse(boxData.get('data_mangas')!);
        DateTime dataAtual = DateTime.now();
        if (dataAtual.isBefore(dataSalva)) {
          String data = await verificaData(cancel: cancel);
          boxData.put('data_mangas', data);
        }
        refresh = dataAtual.isBefore(dataSalva);
      } else {
        String data = await verificaData(cancel: cancel);
        boxData.put('data_mangas', data);
        refresh = true;
      }
    }
    dynamic response;
    try {
      response = await dio.getLink(
        mangasLink,
        refresh: refresh,
        cancelToken: cancel,
        contextError: "Falha ao Listar Mangas",
      );
    } on DioError catch (e) {
      if (e.response == null) return [];
    }
    return TituloModel.fromJsonList(
      response[response.keys.elementAt(0)],
    )!;
  }
}
