import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    if (options.extra.containsKey('refresh')) {
      if (!options.extra['refresh']) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (prefs.containsKey('${options.uri}')) {
          // prefs.remove('${options.uri}');
          return Response(
              data: options.uri.toString().contains('.json')
                  ? json.decode(prefs.getString('${options.uri}'))
                  : prefs.getString('${options.uri}'),
              statusCode: 200);
        }
      }
    }
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        "${response.request.uri}",
        response.request.uri.toString().contains('.json')
            ? json.encode(response.data)
            : response.data.toString());
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) async {
    if (err.type == DioErrorType.CONNECT_TIMEOUT ||
        err.type == DioErrorType.DEFAULT) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('${err.request.uri}')) {
        return Response(
            data: prefs.getString('${err.request.uri}'), statusCode: 200);
      }
    } else {
      return super.onError(err);
    }
  }
}
