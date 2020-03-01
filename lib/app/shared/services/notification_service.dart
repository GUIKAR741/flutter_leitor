import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oktoast/oktoast.dart';

enum NotificationType { primary, info, success, danger, warning }

class NotificationService extends Disposable {
  Color _pegarCorPeloTipo(NotificationType tipo) {
    switch (tipo) {
      case NotificationType.info:
        return Colors.lightBlue;
      case NotificationType.success:
        return Colors.green;
      case NotificationType.danger:
        return Colors.red;
      case NotificationType.warning:
        return Colors.orange;
      case NotificationType.primary:
      default:
        return Colors.blue;
    }
  }

  void notificacaoPadrao({
    String titulo,
    @required String mensagem,
    Icon icon = const Icon(Icons.forum),
    NotificationType tipo = NotificationType.primary,
    int timeout = 3,
    double containerHeight = 80.0,
    BuildContext context,
  }) {
    showToastWidget(
      Material(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: () => dismissAllToast(showAnim: true),
            child: Container(
              color: _pegarCorPeloTipo(tipo),
              padding: EdgeInsets.all(12),
              height: containerHeight ?? 80.0,
              width: MediaQuery.of(Modular.navigatorKey.currentContext)
                      .size
                      .width /
                  1.1,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  icon,
                  Container(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      mensagem,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      handleTouch: true,
      duration: Duration(
        seconds: timeout ?? 3,
      ),
      context: context,
    );
  }

  void notificacaoCarregando() {
    notificacaoPadrao(
      mensagem: "Carregando",
      tipo: NotificationType.info,
      icon: Icon(Icons.refresh),
    );
  }

  @override
  void dispose() {}
}
