import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/hqs/pages/hq/hq_bloc.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_module.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(HqsModule());
  HqBloc bloc;

  setUp(() {
    bloc = HqsModule.to.get<HqBloc>();
  });

  group('HqBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<HqBloc>());
    });
  });
}
