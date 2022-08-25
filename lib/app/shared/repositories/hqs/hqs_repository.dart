import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:leitor/app/shared/interfaces/repository_principal.dart';
import 'package:leitor/app/shared/models/titulo_model.dart';
import 'package:leitor/app/shared/util/constants.dart';

class HqsRepository extends IRepositoryPrincipal {
  @override
  Future<List<TituloModel>?>? pegarListagem({
    bool refresh = false,
    CancelToken? cancel,
  }) async {
    if (!Hive.isBoxOpen('data')) {
      await Hive.openBox<String>('data');
    }
    Box<String> boxData = Hive.box<String>('data');
    if (refresh) {
      String data = await verificaData(cancel: cancel);
      boxData.put('data_hqs', data);
    } else {
      if (boxData.containsKey('data_hqs')) {
        DateTime dataSalva = DateTime.parse(boxData.get('data_hqs')!);
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
        hqsLink,
        refresh: refresh,
        cancelToken: cancel,
        contextError: "Falha ao Listar HQS",
      );
    } on DioError catch (e) {
      if (e.response == null) return [];
    }
    return TituloModel.fromJsonList(response[response.keys.elementAt(0)])!;
  }
}
