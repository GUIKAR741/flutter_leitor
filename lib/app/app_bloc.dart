import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBloc extends Disposable {
  final BehaviorSubject<bool> _tema$ = BehaviorSubject<bool>();
  Stream<bool> get tema => _tema$.stream;

  AppBloc() {
    SharedPreferences.getInstance().then((data){
      _tema$.add(data.getBool('dark'));
    });
  }

  mudarTema(){
    SharedPreferences.getInstance().then((data){
      data.setBool('dark', !(data.getBool('dark') ?? true));
      _tema$.add(data.getBool('dark'));
    });
  } 

  @override
  void dispose() {
    _tema$.close();
  }
}
