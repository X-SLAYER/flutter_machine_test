import 'package:dio/dio.dart';

class RefreshInterceptor extends Interceptor {
  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.requestOptions.headers.containsKey('accessToken')) {
      return handler.reject(err);
    }
  }
}
