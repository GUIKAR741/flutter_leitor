import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_leitor/app/app_module.dart';
// import 'package:flutter_leitor/app/modules/assistir/assistir_bloc.dart';
import 'package:flutter_leitor/app/modules/assistir/assistir_module.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(AssistirModule());
  // AssistirBloc bloc;

  setUp(() {
    // bloc = AssistirModule.to.get<AssistirBloc>();
  });

  group('AssistirBloc Test', () {
    test("First Test", () {
      // expect(bloc, isInstanceOf<AssistirBloc>());
    });
  });
}
