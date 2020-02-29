import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../../shared/interfaces/repository_principal.dart';
import '../../../shared/models/titulo_model.dart';
import '../../../shared/utils/constants.dart';

class HqsRepository extends IRepositoryPrincipal {
  @override
  Future<List<TituloModel>> pegarListagem({
    bool refresh = false,
    CancelToken cancel,
  }) async {
    Box<String> boxData = await box;
    if (refresh) {
      String data = await verificaData(cancel: cancel);
      boxData.put('data_hqs', data);
    } else {
      if (boxData.containsKey('data_hqs')) {
        DateTime dataSalva = DateTime.parse(boxData.get('data_hqs'));
        DateTime dataAtual = DateTime.now();
        if (dataAtual.isBefore(dataSalva)) {
          String data = await verificaData(cancel: cancel);
          boxData.put('data_hqs', data);
        }
        refresh = dataAtual.isBefore(dataSalva);
      } else {
        String data = await verificaData(cancel: cancel);
        boxData.put('data_hqs', data);
        refresh = true;
      }
    }
    dynamic response;
    try {
      response = await dio.getLink(
        HQS,
        refresh: refresh,
        cancelToken: cancel,
        contextError: "Falha ao Listar HQS",
      );
    } on DioError catch (e) {
      if (e.request == null) return [];
    }
    return TituloModel.fromJsonList(response[response.keys.elementAt(0)]);
  }
}
