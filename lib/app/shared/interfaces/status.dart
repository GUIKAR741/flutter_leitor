import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'status.g.dart';

class IStatus = _IStatusBase with _$IStatus;

abstract class _IStatusBase extends HiveObject with Store {
  String titulo;

  @observable
  bool status = false;

  @action
  void mudarStatus({bool add = false}) => status = !add ? !status : add;
}
