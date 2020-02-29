import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../../shared/interfaces/repository_principal.dart';
import '../../../shared/models/titulo_model.dart';
import '../../../shared/utils/constants.dart';

class MangasRepository extends IRepositoryPrincipal {
  @override
  Future<List<TituloModel>> pegarListagem({
    bool refresh = false,
    CancelToken cancel,
  }) async {
    Box<String> boxData = await box;
    if (refresh) {
      String data = await verificaData(cancel: cancel);
      boxData.put('data_mangas', data);
    } else {
      if (boxData.containsKey('data_mangas')) {
        DateTime dataSalva = DateTime.parse(boxData.get('data_mangas'));
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
        MANGAS,
        refresh: refresh,
        cancelToken: cancel,
        contextError: "Falha ao Listar Mangas",
      );
    } on DioError catch (e) {
      if (e.request == null) return [];
    }
    return TituloModel.fromJsonList(
      response[response.keys.elementAt(0)],
    );
  }
}
