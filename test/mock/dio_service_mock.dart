import 'package:flutter_leitor/app/shared/services/dio_service.dart';

import 'dio_mock_adapter.dart';

class DioServiceMock extends DioService {
  bool interceptorValidate = true;

  DioServiceMock() {
    initInterceptor();
    client.httpClientAdapter = DioMockAdapter();
  }

  @override
  bool get hasInterceptor => interceptorValidate ? super.hasInterceptor : true;
}
