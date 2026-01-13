import 'package:dio/dio.dart';

import '../../../utils/dio/dio.dart';
import 'dio_interceptor.dart';

class DioService {
  static Dio? _dio;

  DioService._();

  static Dio get client {
    if (_dio == null) {
      _dio = Dio();
      _dio!.interceptors.clear();
      _dio!.interceptors.add(CurlLoggerDioInterceptor());
      _dio!.interceptors.add(RefreshInterceptor());
      _dio!.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          maxWidth: 120,
        ),
      );
    }
    return _dio!;
  }
}
